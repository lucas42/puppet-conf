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
			alias => '/resources/admin/',
			path  => '/usr/local/lib/python2.7/dist-packages/django/contrib/admin/static/admin/',
		}, {
                        alias => '/resources',
                        path  => "/web/lucos/${directory}/templates/resources",
                }]
        }

}
