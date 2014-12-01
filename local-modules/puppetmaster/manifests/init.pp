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
		group => root,
		mode => 644,
		require => [User["lucas"], Package["puppetmaster"]],
		recurse => true,
	}
	class { 'puppetdb::master::config':
	}
	class { 'puppetdb::server':

		# Hardcode for now.  TODO: use puppetdb to work it out (how meta!)
		database_host => '10.0.0.2',
	}
}
