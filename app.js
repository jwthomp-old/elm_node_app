console.log("Started!");

var Elm = require('./build/elm');

var app = Elm.Spelling.worker();

app.ports.ping.subscribe(function(word) {
	app.ports.pong.send(word);
});

app.ports.dbg.subscribe(function(word) {
	console.log('debug: ', word);
});
