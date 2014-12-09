class hostfirewall {
  $package_name = 'iptables-persistent'
  $service_name = 'iptables-persistent'
  package { $package_name:
    ensure => present,
  }
  service { $service_name:
    ensure    => undef,
    enable    => $enable,
    hasstatus => true,
    require   => Package[$package_name],
  }
  file { '/etc/iptables/rules.v4':
    ensure => file,
    source => 'puppet:///modules/hostfirewall/rules.v4',
    notify => Service[$service_name],
  }
}
