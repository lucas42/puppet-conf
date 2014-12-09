# Needs to inherit from login in order to add lucas to the lucos group
class homebox::lucos inherits login{
        user { "lucos":
                ensure => present,
                uid => 2001,
                gid => 2001,
                home => "/web/lucos",
                shell => "/bin/bash",
        }
        group { "lucos":
                ensure => present,
                gid => 2001,
        }

        # See http://grokbase.com/t/gg/puppet-users/127bxr8ef4/how-to-conditionally-add-users-to-a-virtualized-group
        user["lucas"] {
                groups +> ["lucos"],
                require +> Group["lucos"],
        }
        file { "/web/lucos":
                owner => lucos,
                group => lucos,
                mode => 775,
                require => [User["lucos"], File['/web']],
        }
        file { "/web":
                ensure => "directory",
                mode => 755,
                owner => "lucas",
                require => [User["lucas"]],
        }
}
