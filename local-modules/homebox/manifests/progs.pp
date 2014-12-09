class homebox::progs {
        package { "python":
                ensure => "latest",
        }
        package { "python-memcache":
                ensure => "latest",
                require => Package['memcached', 'python'],
        }
        package { "memcached":
                ensure => "latest",
        }
        package { "python-pysqlite2":
                ensure => "latest",
                require => Package['python'],
        }
        package { "ffmpeg":
                ensure => "latest",
        }
        package { "mplayer":
                ensure => "latest",
        }
        package { "vlc":
                ensure => "latest",
        }
        package { "get-iplayer":
                ensure => "latest",
                require => Package['ffmpeg', 'mplayer', 'vlc'],
        }
        cron { "get_iplayer":
                command => "get_iplayer --pvr --type=tv,radio",
                user => "lucos",
                ensure => present,
                require => [Package["get-iplayer"], File["/web/lucos/.get_iplayer/options"], File["/web/lucos/.get_iplayer/pvr/all"]],
                minute => 0,
        }
        file { "/web/lucos/.get_iplayer/options":
                owner => lucos,
                group => lucos,
                mode => 644,
                source => "puppet:///modules/homebox/get_iplayer/options",
                require => File["/web/lucos/.get_iplayer"],
        }

        file { "/web/lucos/.get_iplayer":
                ensure => "directory",
                owner => lucos,
                group => lucos,
                mode => 755,
                require => [File['/web/lucos']],
        }
        file { "/web/lucos/.get_iplayer/pvr/all":
                owner => lucos,
                group => lucos,
                mode => 644,
                source => "puppet:///modules/homebox/get_iplayer/pvrlist",
                require => File["/web/lucos/.get_iplayer/pvr"],
        }
        file { "/web/lucos/.get_iplayer/pvr":
                ensure => "directory",
                owner => lucos,
                group => lucos,
                mode => 755,
                require => [File['/web/lucos/.get_iplayer']],
        }

}
