class standardnode::puppetagentconfig {
	package { 'puppet':
		ensure => 'latest',
	} ~>
	augeas { 'puppet.conf':
		incl    => '/etc/puppet/puppet.conf',
		lens    => 'puppet.lns',
		changes => [
			"set main/server ${::servername}",
			'set main/pluginsync true',
		],
	} ~>
	file { '/etc/default/puppet':
		ensure  => 'file',
		content => 'START=yes'
	} ~>
	service { 'puppet':
		ensure => 'running',
	}
}
