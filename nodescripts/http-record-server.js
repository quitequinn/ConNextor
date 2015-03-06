var http = require('http');
var url = require('url');

var port = process.argv[2];

var server = http.createServer(function (request, response) {
	if (request.method != 'GET')
		return response.end('false');

	var name = url.parse(request.url, true).query.name;
	var email = url.parse(request.url, true).query.email;
	var interest = url.parse(request.url, true).query.interest;
	var altinterest = url.parse(request.url, true).query.altinterest;
	var source = url.parse(request.url, true).query.source;
	var altsource = url.parse(request.url, true).query.altsource;
	if (email != null) {
		console.log(name + "," + 
					email + "," + 
					interest + "," + 
					altinterest + "," + 
					source + "," + 
					altsource);
		response.end('true');
	}

	response.end('false');

});

server.listen(port);
