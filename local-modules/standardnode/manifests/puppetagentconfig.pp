class standardnode::puppetagentconfig {
	augeas { 'puppet.conf':
		incl    => '/etc/puppet/puppet.conf',
		lens    => 'puppet.lns',
		changes => [
			"set main/server ${::servername}",
			'set main/pluginsync true',
		],
	}
}
