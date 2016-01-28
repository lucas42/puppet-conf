class puppetmaster {
	package { ["puppetmaster","librarian-puppet"]:
		ensure => latest,
	}
	service { "puppetmaster":
		enable => true,
		ensure => "running",
		require => Package["puppetmaster"],
	}
	file { "/etc/puppet":
		ensure => "directory",
		owner => lucas,
		require => [User["lucas"], Package["puppetmaster"]],
		recurse => true,
	}
	class { 'puppetdb::master::config':
	}
	class { 'puppetdb::server':

		# Hardcode for now.  TODO: use puppetdb to work it out (how meta!)
		database_host      => '10.0.0.2',
		listen_address     => '0.0.0.0',
		ssl_listen_address => '0.0.0.0',
	}
	package { 'ruby-puppetdb':
		provider => 'gem',
	}
	tidy { "/var/lib/puppet/reports":
		age => "1w",
		recurse => true,
	}
	package { 'puppet-lint':
		provider => 'gem',
	}
}
