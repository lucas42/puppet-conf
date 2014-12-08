node sssesperanto {
	include tools
	include login
	include monitoring
	include puppetmaster
}
node hive {
	include tools
	include login
	include hostmachine
}
node colonial1 {
	Package { provider => "macports" }
	include tools
	include login
}
node beliskner {
	include tools
	include login

	class { 'puppetdb::database::postgresql':
		listen_addresses => "*"
	}
	include zabbix::database::remotepostgresql
}
node thunderbird5 {
	include tools
	include login
	$dbhosts = query_nodes('Class[\'zabbix::database::remotepostgresql\']', 'ipaddress')
	class { 'zabbix::server':
		dbhost           => $dbhosts[0],
		manage_resources => true,
	}

	# HACK: On wheezy, puppet looks for gems in a different place to where
	# they're installed.
	# This adds zabbixapi to ruby's load path (note: 1st puppet run will
	# still fail :( )
	file { '/etc/profile.d/rubylib.sh':
		content => 'export RUBYLIB=\'/var/lib/gems/1.9.1/gems/zabbixapi-2.4.0/lib\''
	}
}
node webstar {
        include tools
        include login
	include monitoring
}
