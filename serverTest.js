// Load the http module to create an http server
var http = require('http')

// Configure the HTTP server to respond with Hello World to all requests

var server = http.createServer(function (request, response) {
	response.writeHead(200, {"Content-Type": "text/plain"});
	console.log(request.url);
	response.end("Hello World\n");
});

// Listen on port 8000, IP defaults to 127.0.0.1
server.listen(8000);

console.log("Server running at http://127.0.0.1:8000/");