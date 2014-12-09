class homebox::apache {
        group { "www-data":
                ensure => present,
                gid => 33,
        }
        package {"apache2":
                ensure => "latest",
                require => Group['www-data'],
        }
        file {"/etc/apache2/ports.conf":
                ensure => present,
                source => "puppet:///modules/homebox/apache/ports.conf",
                require => Package["apache2"],
                notify => Service["apache2"],
        }

   service { "apache2":
      ensure => running,
      hasstatus => true,
      hasrestart => true,
      require => Package["apache2"],
   }

   define site ( $ensure = 'present') {
                exec { "reload-apache2-$name":
                        command => "/etc/init.d/apache2 reload",
                        refreshonly => true,
                }

      case $ensure {
                'present' : {
                        exec { "/usr/sbin/a2ensite $name":
                                unless => "/bin/readlink -e /etc/apache2/sites-enabled/$name",
                                notify => Exec["reload-apache2-$name"],
                                require => [Package['apache2'], File["/etc/apache2/sites-available/$name"]],
                        }
                        file { "/etc/apache2/sites-available/$name":
                                owner => root,
                                group => root,
                                mode => 440,
                                source => "puppet:///modules/homebox/apache/$name",
                                notify => Exec["reload-apache2-$name"],
                                require => Package["apache2"],
                        }
                }
                'absent' : {
            exec { "/usr/sbin/a2dissite $name":
               onlyif => "/bin/readlink -e /etc/apache2/sites-enabled/$name",
               notify => Exec["reload-apache2-$name"],
               require => Package["apache2"],
            }
         }
         default: { err ( "Unknown ensure value: '$ensure'" ) }
      }
   }
}
