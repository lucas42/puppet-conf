#
# Sets up an nginx server for unwrapping ssl before forwarding requests to varnish
# Assumes that certs for each domain have been set using letsencrypt
# and put in letsencrpyt's default directory structure
#
class sslunwrap {
	package { 'nginx':
		ensure => present,
	}
	service { 'nginx':
		ensure     => running,
		hasrestart => true,
		require    => Package['nginx'],
	}
        file { "/etc/nginx/sites-enabled/default":
                ensure => absent,
		notify => Service['nginx'],
	}
	exec { '/usr/bin/openssl dhparam -out /etc/ssl/private/dhparams.pem 2048':
		creates => '/etc/ssl/private/dhparams.pem',
		require => Package['nginx'],
		notify  => Service['nginx'],
		timeout => 0, # Apparently this can take a LONG time
	}
	file { '/etc/nginx/nginx.conf':
		ensure  => present,
		source  => 'puppet:///modules/sslunwrap/nginx.conf',
		owner   => 'root',
		group   => 'root',
		require => Package['nginx'],
		notify  => Service['nginx'],
	}


	sslunwrap::site { 'tfluke.uk': }
	sslunwrap::site { 'app.tfluke.uk': }
	sslunwrap::site { 'www.tfluke.uk': }
	sslunwrap::site { 'contacts.l42.eu': }
	sslunwrap::site { 'zabbix.l42.eu': }
	sslunwrap::site { 'puppetdb.l42.eu': }
}
