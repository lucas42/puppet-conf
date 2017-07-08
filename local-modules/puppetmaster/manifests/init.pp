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
	cron { 'tidy-reports':
		command => 'find /var/lib/puppet/reports/ -type f -ctime +7 | xargs -P 4 -n 20 rm -f',
		user    => 'root',
		hour    => 3,
		minute  => 13,
	}
	package { 'puppet-lint':
		provider => 'gem',
	}
}
