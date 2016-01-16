class nodejs {
	package { ["nodejs", "npm"]:
		ensure => installed,
	}

	# Debian calls node a different name than anything expecting to run it.
	file { '/usr/bin/node':
		ensure => '/usr/bin/nodejs'
	}
}
