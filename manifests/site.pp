node sssesperanto {
	include tools
	include login
	include puppetmaster
}
node hive {
	include tools
	include login
	include hostmachine
}
node colonial1 {
	Package { provider => "macports" }
	include tools
	include login
}