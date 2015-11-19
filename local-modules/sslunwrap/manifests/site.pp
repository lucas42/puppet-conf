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
	exec { "/usr/sbin/service nginx stop && /etc/letsencrypt/letsencrypt-auto certonly --standalone --standalone-supported-challenges tls-sni-01 --server https://acme-v01.api.letsencrypt.org/directory --agree-dev-preview --agree-tos -d ${domain}":
		creates => "/etc/letsencrypt/live/${domain}",

		# Not sure whether nginx needs bounced when certs change, but do it just in case.
		notify  => Service['nginx'],
	}
}

