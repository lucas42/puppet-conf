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
	include zabbix::database
}
node thunderbird5 {
	include standardnode
	include zabbixserver
}
node webstar {
	include standardnode
	include varnish
	class { 'sslunwrap':
		domains => [
			'tfluke.uk',
			'app.tfluke.uk',
			'www.tfluke.uk',
			'contacts.l42.eu',
			'zabbix.l42.eu',
			'puppetdb.l42.eu',
			'am.l42.eu',
			'auth.l42.eu',
			'l42.eu',
			'notes.l42.eu',
			'speak.l42.eu',
			'ceol.l42.eu',
			'seinn.l42.eu',
		],
	}
}
node interceptor {
	include standardnode
	include homebox
	class { 'sslunwrap':
		domains => [
			'private.l42.eu',
			'home.l42.eu',
			'staticmedia.l42.eu',
			'photos.l42.eu',
		],
	}
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
	include nodejs
	include java
}
node default {
	include standardnode
}
