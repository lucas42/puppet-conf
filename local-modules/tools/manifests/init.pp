class tools {
	package { ["curl","dnsutils","git","screen","nano"]:
			ensure => latest;
	}
}
