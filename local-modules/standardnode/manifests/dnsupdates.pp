class standardnode::dnsupdates (
	$dnsserver,
	$authkey,
){
	$minoffset = fqdn_rand(10)
	cron { 'updatedns':
		command => "curl -X PUT 'http://${dnsserver}/servers/${::hostname}' -H 'Authorization: Key ${authkey}'",
		user => "root",
		minute => "$minoffset-59/10",
		ensure => present,
	}
}
