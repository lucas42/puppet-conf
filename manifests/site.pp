node sssesperanto {
	include tools
	include login
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
	class { 'zabbix::server':
		zabbix_url => 'zabbix.l42.eu',
		dbhost     => '10.0.0.2',
	}
}
