node sssesperanto {
	include standardnode
	include puppetmaster
}
node hive {
	include standardnode
	include hostmachine
}
node colonial1 {
	Package { provider => "macports" }
	include tools
	include login
}
node beliskner {
	include standardnode

	class { 'puppetdb::database::postgresql':
		listen_addresses => "*"
	}
	include zabbix::database::remotepostgresql
}
node thunderbird5 {
	include standardnode
	$dbhosts = query_nodes('Class[\'zabbix::database::remotepostgresql\']', 'ipaddress')
	class { 'zabbix::server':
		dbhost	         => $dbhosts[0],
		manage_resources => true,
		zabbix_timezone  => 'Europe/London',
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
	include standardnode
	include varnish
}
node interceptor {
	include standardnode
	include homebox
}
node default {
	include standardnode
}
