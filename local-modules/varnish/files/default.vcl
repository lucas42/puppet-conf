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
backend githubpages {
	.host = "lucas42.github.io";
	.port = "80";
}
backend tflukeapp {
	.host = "tfluke.herokuapp.com";
	.port = "80";
}

# Hosts trusted to do TLS unwrapping
acl tls {
	"localhost";
}
sub vcl_recv {
	
	# Prevent clients from spoofing their protocol
	if (!client.ip ~ tls) {
		remove req.http.X-Forwarded-Proto;
	}

	# Redirect all non-https traffic to https
	if (req.http.X-Forwarded-Proto != "https") {
		error 799 "https://"+req.http.host+req.url;
	}

	if (req.http.host == "zabbix.l42.eu") {
		set req.backend = zabbix;
	} elsif (req.http.host == "puppetdb.l42.eu") {
		set req.backend = puppetdb;
	} elseif (req.http.host == "contacts.l42.eu") {
		set req.backend = contacts;
	} elseif (req.http.host == "tfluke.uk") {
		set req.backend = githubpages;
	} elseif (req.http.host == "www.tfluke.uk") {
		set req.http.host = "tfluke.uk";
                set req.backend = githubpages;
	} elseif (req.http.host == "app.tfluke.uk") {
		set req.backend = tflukeapp;
        } elseif (req.http.host == "fionnblaney.co.uk") {
                set req.backend = githubpages;
	} else {
		error 499 "Host Not Found";
	}
}

sub vcl_error {
	if (obj.status == 799) {
		set obj.http.Location = obj.response;
		set obj.status = 302;
		return (deliver);
	}
}
