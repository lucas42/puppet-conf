class login {
	case $operatingsystem {
		Darwin: { 
			$home='/Users'
			$rootgrp = 'wheel'
			$roothome = '/var/root'
		}
		default: { 
			$home='/home' 
			$rootgrp = 'root'
			$roothome = '/root'
		}
	}
	package { "sudo":
		ensure => "latest"
	}
	file { "/etc/sudoers":
		owner => root,
		group => $rootgrp,
		mode => 440,
		source => "puppet:///modules/login/sudoers",
		require => [Package["sudo"],User["lucas"]],
	}
	file { "${home}/lucas/.bashrc":
		owner => lucas,
		group => lucas,
		mode => 750,
		source => "puppet:///modules/login/bashrc",
		require => File["${home}/lucas"],
	}
	file { "/etc/motd":
		owner => root,
		group => $rootgrp,
		mode => 644,
		source => "puppet:///modules/login/motd",
	}
	file { "${roothome}/.bashrc":
		owner => root,
		group => $rootgrp,
		mode => 750,
		source => "puppet:///modules/login/bashrc",
	}
	file { "${home}/lucas/.bash_profile":
		owner => lucas,
		group => lucas,
		mode => 750,
		source => "puppet:///modules/login/bash_profile",
		require => File["${home}/lucas"],
	}
	file { "${home}/lucas/.gitconfig":
		owner => lucas,
		group => lucas,
		mode => 750,
		source => "puppet:///modules/login/gitconfig",
		require => File["${home}/lucas"],
	}
	file { "${home}/lucas/.ssh":
		ensure => "directory",
		owner => lucas,
		group => lucas,
		mode => 700,
		require => File["${home}/lucas"],
	}
	ssh_authorized_key { "Luke's_key":
		ensure => present,
		key => "AAAAB3NzaC1yc2EAAAABIwAAAQEAtyhe9NzBfQbk6MAVYOjP1IfDO7/27+kqFZfnJylylhXzG7J82NAGQ6DEwq0z/IVQlkipdoVF9YjxcTkGB/k2D2B+bn3mgBGtZqE8Rap30uFYe5MlJyUW8m4u+mCVatyuLHVc1se240Nu8jKG/ewpIuYweWpug3uoNCGtyZxwZsaYByT8b2r3n5ZYtgCaLV4BpGpZEULkHpYs35Bf+5AOqDWL3uHs2JLdMtcG7AcEOvFgWaw3G9kSeCGVqOp0wFl2xdY0jLzQwPhdbjdigmSLXGvidFtvouuCV+Kjh91/F3GTQQn9mCz9wpv5hWPUclpBSW8hUf3XwIWJTrP9xQCxFw==",
		type => "ssh-rsa",
		user => "lucas",
		require => [File["${home}/lucas/.ssh"],User["lucas"]],
	}
	group { "lucas":
		ensure => present,
		gid => 2000,
	}
	user { "lucas":
		ensure => present,
		gid => 2000,
		uid => 2000,
		shell => "/bin/bash",
		home => "${home}/lucas",
	}
	file { "${home}/lucas":
		ensure => "directory",
		owner => lucas,
		group => lucas,
		mode => 755,
		require => User["lucas"],
	}
	user { "pi":
		ensure => absent,
		require => User["lucas"],
	}
	group { "pi":
		ensure => absent,
		require => [Group["lucas"], User["pi"]],
	}
}
