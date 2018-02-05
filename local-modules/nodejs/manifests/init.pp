class nodejs {
	# TODO: ensure version 8 is installed, (not version 4 which is the default in Debian Stretch)
	package { ["nodejs"]:
		ensure => installed,
	}
}
