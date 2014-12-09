# Installs varnish from source
# TODO: is this still required?
# It might just be that the tweaked default/varnish file
# is enough to run repo varnish on a raspberry pi
class homebox::varnish {
        file { "/etc/default/varnish":
                owner => root,
                group => root,
                mode => 440,
                source => "puppet:///modules/homebox/etc-default-varnish",
        }
        file { "/etc/varnish/default.vcl":
                owner => lucos,
                group => lucos,
                mode => 644,

                source => "puppet:///modules/homebox/default.vcl",
        }
        file { "/usr/sbin/varnishd":
                ensure => "/usr/local/sbin/varnishd",
        }
        $dependancies = ["automake", "libtool", "python-docutils"]
        package { $dependancies: ensure => "latest" }
        user { "varnishd":
                ensure => present,
        }
        service { "varnish":
                enable => true,
                ensure => "running",
                pattern => "varnishd",
                hasstatus => false,
                require => [File["/etc/default/varnish", "/etc/varnish/default.vcl", "/usr/sbin/varnishd"]],
        }
}

