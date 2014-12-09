class varnish {
	package {'varnish':
		ensure => 'present',
	}
	service {'varnish':
		ensure => 'running',
		require => Package['varnish'],
	}
	file {'/etc/varnish/default.vcl':
		ensure => present,
		source => 'puppet:///modules/varnish/default.vcl',
		notify => Service['varnish'],
		require => Package['varnish']
	}
        file { "/etc/default/varnish":
                owner => root,
                group => root,
                mode => 440,
                source => 'puppet:///modules/varnish/defaultvarnish',
                require => Package['varnish'],
                notify => Service['varnish'],
        }

}
