class django {
	class { 'apt::backports':
		pin_priority => 500,
	} ->
        package { ["python-django", "python-psycopg2"]:
                ensure => "latest",
        }
	file { "/web/lucos":
		ensure  => directory,
                owner   => lucos,
                group   => lucos,
                mode    => 777,
                require => [User["lucos"], File['/web']],
        }
        file { "/web":
                ensure => "directory",
                mode   => 755,
        }
        user { "lucos":
                ensure => present,
                uid    => 2001,
                gid    => 2001,
                home   => "/web/lucos",
                shell  => "/bin/bash",
        }
        group { "lucos":
                ensure => present,
                gid => 2001,
        }
}
