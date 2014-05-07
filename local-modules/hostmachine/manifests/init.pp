class hostmachine {
	package {
		'xen-linux-system-amd64':
			ensure => latest;
		'xen-tools':
			ensure => latest;
	}
}
