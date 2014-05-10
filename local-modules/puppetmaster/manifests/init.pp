class puppetmaster {
	package { ["puppetmaster","librarian-puppet"]:
		ensure => latest,
	}
	service { "puppetmaster":
		enable => true,
		ensure => "running",
		require => Package["puppetmaster"],
	}
}
