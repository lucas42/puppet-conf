class tools {
	package { ["curl","screen","nano","puppet","vim"]:
			ensure => latest
	}
	if $operatingsystem == 'Darwin' {
		package { ["git-core"]:
			ensure => latest
		}
	} else {
		package { ["net-tools","dnsutils","git","telnet",'lsof']:
			ensure => latest
		}
	}
}
