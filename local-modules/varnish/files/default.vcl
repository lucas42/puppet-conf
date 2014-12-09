backend zabbix {
	.host = "10.0.0.3";
	.port = "80";
}
backend puppetdb {
	.host = "10.0.0.1";
	.port = "8080";
}

sub vcl_recv {
	if (req.http.host == "zabbix.l42.eu") {
		set req.backend = zabbix;
	} elsif (req.http.host == "puppetdb.l42.eu") {
		set req.backend = puppetdb;
	}
}
