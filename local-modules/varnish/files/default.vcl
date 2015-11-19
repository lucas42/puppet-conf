backend zabbix {
	.host = "10.0.0.3";
	.port = "80";
}
backend puppetdb {
	.host = "10.0.0.1";
	.port = "8080";
}
backend contacts {
	.host = "10.0.0.6";
	.port = "80";
}
backend tfluke {
	.host = "lucas42.github.io";
	.port = "80";
}
backend tflukeapp {
	.host = "tfluke.herokuapp.com";
	.port = "80";
}
sub vcl_recv {
	if (req.http.host == "zabbix.l42.eu") {
		set req.backend = zabbix;
	} elsif (req.http.host == "puppetdb.l42.eu") {
		set req.backend = puppetdb;
	} elseif (req.http.host == "contacts.l42.eu") {
		set req.backend = contacts;
	} elseif (req.http.host == "tfluke.uk") {
		set req.backend = tfluke;
	} elseif (req.http.host == "app.tfluke.uk") {
		set req.backend = tflukeapp;
	} else {
		error 499 "Host Not Found";
	}
}
