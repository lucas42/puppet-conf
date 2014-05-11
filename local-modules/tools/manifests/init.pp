class tools {
	package { ["curl","screen","nano","puppet"]:
			ensure => latest
	}
	if $operatingsystem == 'Darwin' {
		package { ["git-core"]:
			ensure => latest
		}
	} else {
		package { ["net-tools","dnsutils","git"]:
			ensure => latest
		}
	}
}
