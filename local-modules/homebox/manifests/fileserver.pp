class homebox::fileserver (
	$secret
) {
        homebox::apache::site {"fileserver":
                ensure => 'present',
        }
        file { "/web/lucos/fileserver":
                ensure => "directory",
                owner => lucos,
                group => lucos,
                mode => 755,
                require => [User["lucos"], File['/web/lucos']],
        }
        file { "/web/lucos/fileserver/$secret":
                ensure => "directory",
                owner => lucos,
                group => lucos,
                mode => 755,
                require => File["/web/lucos/fileserver"],
        }
        file { "/web/lucos/fileserver/$secret/medlib":
                ensure => link,
                target => '/medlib',
                require => [File["/web/lucos/fileserver/$secret"], mount['/medlib']],
        }

        homebox::apache::site {"publicmedia":
                ensure => 'present',
        }
        file { '/web/lucos/public/':
                ensure => link,
                target => '/medlib/public/',
                owner => lucos,
                group => lucos,
                mode => 755,
                require => [File["/web/lucos/"], File["/medlib/public/"]],
        }
        file { '/medlib/public/':
                ensure => directory,
                owner => lucos,
                group => lucos,
                mode => 775,
                require => [mount["/medlib"]],
        }
        file { '/medlib/public/time/':
                ensure => directory,
                owner => lucos,
                group => lucos,
                mode => 775,
                require => [File["/medlib/public/"]],
        }
        mount { '/medlib':
                device => "192.168.1.64:/medlib",
                fstype => "nfs",
                ensure => "mounted",
                atboot => true,
                options => "rw,hard,intr,nolock",
                require => [File['/medlib'], Package["nfs-common"]],
        }
        file { '/medlib':
                ensure => "directory",
                mode => 755,
        }
        homebox::apache::site {"photos":
                ensure => 'present',
        }
#        mount { '/web/lucos/photos/':
#                device => "192.168.0.5:/photos",
#                fstype => "nfs",
#                ensure => "mounted",
#                atboot => true,
#                options => "rw,hard,intr,nolock",
#                require => [File['/web/lucos/photos'], Package["nfs-common"]],
#        }
        file { '/web/lucos/photos/':
                ensure => "directory",
                mode => 755,
        }
#        file { '/web/lucos/photos/public':
#                ensure => "directory",
#                mode => 755,
#                require => Mount['/web/lucos/photos/'],
#        }
#        file { '/web/lucos/photos/public/uuid':
#                ensure => "directory",
#                mode => 755,
#                require => File['/web/lucos/photos/public'],
#                owner => "lucos",
#                group => "lucos",
#        }
        package { "uuid-runtime":
                ensure => latest,
        }
        package { "nfs-common":
                ensure => installed,
        }
}
