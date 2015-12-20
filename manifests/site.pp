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
	include zabbixserver
}
node webstar {
	include standardnode
	include varnish
	include sslunwrap
}
node interceptor {
	include standardnode
	include homebox
}
node olympiccarrier {
	include standardnode
	class {'django':
		domain      => 'contacts.l42.eu',
		directory   => 'lucos_contacts',
		application => 'agents',
	}
}
node daedalus {
	include standardnode
	include lucos
	include systemd
}
node default {
	include standardnode
}
