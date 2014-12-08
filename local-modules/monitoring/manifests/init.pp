class monitoring {
	$zabbixservers = query_nodes('Service[\'zabbix-server\']', 'ipaddress')
	class { 'zabbix::agent':
		server           => $zabbixservers[0],
		manage_resources => true,
		logfile          => '/var/log/zabbix-agent/zabbix_agentd.log',
	}
}
