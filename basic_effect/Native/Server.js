var _jwthomp$et$Native_Server = function() {
	var listen = function(port, onMessage) {
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
			var http = require('http');
			var server = http.createServer(function(req, res) {
				_elm_lang$core$Native_Scheduler.rawSpawn(A2(onMessage, server, req));
				res.end();
			}).listen(port);
			
			callback(_elm_lang$core$Native_Scheduler.succeed(server));

			return function() {
				server.close();
			};
		});
		
		
	};
	
	return {
		listen: listen
	};
}();
