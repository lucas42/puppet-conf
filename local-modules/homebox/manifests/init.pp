# Some legacy manifests transfered across from an old puppetmaster
# TODO: refactor this module out
class homebox {
	class { 'homebox::varnish': }
	class { 'homebox::apache': } ->
	class { 'homebox::lucos': } ->
	class { 'homebox::fileserver': } ->
	class { 'homebox::progs': }
}
