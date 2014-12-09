class standardnode::time {
	include ntp
	class { 'timezone':
		timezone => 'Europe/London',
	}
}
