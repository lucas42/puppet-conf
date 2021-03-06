define sslunwrap::site () {
	$domain = $name
	file { "/etc/nginx/sites-enabled/$domain":
		ensure  => present,
		content => template("${module_name}/site.erb"),
		notify  => Service['nginx'],
	}

	# Assumes that letsencript-auto has already been install
	# TODO: automate installation of said script
	# Need to stop nginx first as letsencrypt uses port 443 for verification
	# TODO: use nginx plugin for letsencript once it's stable
	exec { "/usr/sbin/service nginx stop; /etc/letsencrypt/letsencrypt-auto certonly --standalone --standalone-supported-challenges tls-sni-01 --server https://acme-v01.api.letsencrypt.org/directory --agree-dev-preview --agree-tos -d ${domain}; /usr/sbin/service nginx start":
	
		# Only run if the cert directory doesn't exist, or the cert will expire in the next 25 days
		unless    => "/bin/bash -c 'if [ ! -d \"/etc/letsencrypt/live/${domain}\" ] || [[ `/etc/nginx/checkexpiry.sh ${domain}`  -lt 2160000 ]]; then false; fi'",
		cwd       => '/etc/letsencrypt/',
		timeout   => 1500,
		logoutput => true,
		require   => File['/etc/nginx/checkexpiry.sh'],
	}
}

