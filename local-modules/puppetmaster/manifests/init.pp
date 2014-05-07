class puppetmaster {
	package { "puppetmaster":
		ensure => latest
	}
	package { "librarian-puppet":
		ensure => latest,
	}
}
