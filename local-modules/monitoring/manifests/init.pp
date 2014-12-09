class monitoring (
	$internal = true
) {
	# For nodes on the same subnet as zabbix, use ip addresses
	if ($internal) {
		$key = 'ipaddress'
		$agent_use_ip = true
		$listenip = $::ipaddress
	# For external nodes, use DNS
	} else {
		$key = 'fqdn'
		$agent_use_ip = false
	}
	$zabbixservers = query_nodes('Service[\'zabbix-server\']', $key)
	class { 'zabbix::agent':
		server           => $zabbixservers[0],
		manage_resources => true,
		agent_use_ip     => $agent_use_ip,
		listenip         => $listenip,
	}
}
