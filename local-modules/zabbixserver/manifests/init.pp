class zabbixserver {
	
	# The zabbix::server class handles most dependencies, just not PHP
	# No idea why, so I have to install that dependency here :S
	class { 'apache':
		mpm_module => 'prefork',
	}
	include apache::mod::php

        $dbhosts = query_nodes('Class[\'zabbix::database\']', 'ipaddress')
	class { 'postgresql::client': }
        class { 'zabbix::server':
		database_host     => $dbhosts[0],
		alertscriptspath  => '/etc/zabbix/alert.d',
        } ->
	class { 'zabbix::web':
		database_host     => $dbhosts[0],
		manage_resources => true,
		zabbix_timezone  => 'Europe/London',
	} ->
	class { 'zabbixserver::mail': }

        # HACK: On wheezy, puppet looks for gems in a different place to where
        # they're installed.
        # This adds zabbixapi to ruby's load path (note: 1st puppet run will
        # still fail :( )
        file { '/etc/profile.d/rubylib.sh':
                content => 'export RUBYLIB=\'/var/lib/gems/1.9.1/gems/zabbixapi-2.4.0/lib\''
        }
}
