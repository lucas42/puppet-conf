#
# Sets up an nginx server for unwrapping ssl before forwarding requests to varnish
# Assumes that certs for each domain have been set using letsencrypt
# and put in letsencrpyt's default directory structure
#
# ## Params
# domains - mandatory.  An array of domains to do ssl unwrapping for
# Public DNS for these domains must point to this server
#
class sslunwrap (
	$domains,
){
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
	file { '/etc/nginx/checkexpiry.sh':
                ensure  => present,
                source  => 'puppet:///modules/sslunwrap/checkexpiry.sh',
                owner   => 'root',
                group   => 'root',
                require => Package['nginx'],
		mode    => 'a+x',
	}

	file {'/etc/zabbix/zabbix_agentd.d/certexpiry.conf':
		content => 'UserParameter=certexpiry[*],/etc/nginx/checkexpiry.sh $1',
		owner   => 'zabbix',
		group   => 'zabbix',
		require => Package['zabbix-agent'],
		notify  => Service['zabbix-agent'],
	}

	sslunwrap::site {$domains:}
}
