class zabbixserver::mail (
	$email,
	$password,
) {
	package { 'msmtp':
		ensure => 'present',
	}
	file { '/etc/msmtprc':
		ensure  => 'file',
		content => template('zabbixserver/msmtprc.erb'),
	}
	file { '/etc/zabbix/alert.d/zext_msmtp.sh':
		ensure  => 'file',
		content => template('zabbixserver/zext_msmtp.sh.erb'),
		mode    => '0755',
	}
}
