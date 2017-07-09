class golang {
	package { "golang":
		ensure => installed,
	}
	directory { "/web/lucos/go":
		ensure => exists,
	}
	package { "sqlite3":
		ensure => installed,
	}
}
