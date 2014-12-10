class hostfirewall {
  $package_name = 'iptables-persistent'
  package { $package_name:
    ensure => present,
  }
  exec { 'refresh-firewall':
    command => '/sbin/iptables-restore < /etc/iptables/rules.v4',
    refreshonly => true
  }
  file { '/etc/iptables/rules.v4':
    ensure => file,
    source => 'puppet:///modules/hostfirewall/rules.v4',
    notify => Exec['refresh-firewall'],
  }
}
