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

	sslunwrap::site { 'tfluke.uk': }
	sslunwrap::site { 'app.tfluke.uk': }
	sslunwrap::site { 'www.tfluke.uk': }
	sslunwrap::site { 'contacts.l42.eu': }
	sslunwrap::site { 'zabbix.l42.eu': }
}
