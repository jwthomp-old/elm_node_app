var _jwthomp$et$Native_Server = function() {
	var listen = function(port) {
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
			var http = require('http');
			var server = http.createServer(function(req, res) {
				res.end();
			}).listen(port);
			
			_elm_lang$core$Native_Scheduler.succeed(server);

			return function() {
				server.close();
			};
		});
		
		
	};
	
	return {
		listen: listen
	};
}();
