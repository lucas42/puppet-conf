class django (
	$domain,
	$directory,
	$application,
){
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
	class { 'apache':  }
	class { 'apache::mod::wsgi':
		wsgi_python_path   => "/web/lucos/${directory}",
	}
	apache::vhost { $domain:
		port    => 80,
                docroot => "/web/lucos/${directory}/${application}",
		docroot_owner => 'lucas',
		docroot_group => 'lucas',
                wsgi_script_aliases         => { '/' => "/web/lucos/${directory}/${application}/wsgi.py" },
		aliases => {
			alias => '/media/admin/',
			path  => '/usr/share/python-django-common/django/contrib/admin/static/admin/',
		}
        }

}
