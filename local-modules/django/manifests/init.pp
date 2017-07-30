class django (
	$domain,
	$directory,
	$application,
){
	class { 'apt::backports':
		pin => 500,
	} ->
        package { ["python-pip", "libpq-dev", "python-dev"]:
                ensure => "latest",
        } ->
	package { "django":
		ensure   => "1.11.3",
		provider => "pip",
	} ->
	package { "psycopg2":
		ensure   => "2.7.3",
		provider => "pip",
	}
	include lucos
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
		aliases => [{
			alias => '/media/admin/',
			path  => '/usr/share/pyshared/django/contrib/admin/static/admin/',
		}, {
			alias => '/favicon.ico',
			path  => "/web/lucos/${directory}/templates/resources/logo.png",
		}, {
			alias => '/icon',
			path  => "/web/lucos/${directory}/templates/resources/logo.png",
		}, {
                        alias => '/bootloader',
                        path  => '/web/lucos/core/bootloader.js',
                }]
        }

}
