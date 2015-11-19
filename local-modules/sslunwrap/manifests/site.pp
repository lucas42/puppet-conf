define sslunwrap::site () {
	$domain = $name
	file { "/etc/nginx/sites-enabled/$domain":
		ensure  => present,
		content => template("${module_name}/site.erb"),
		notify  => Service['nginx'],
	}
}

