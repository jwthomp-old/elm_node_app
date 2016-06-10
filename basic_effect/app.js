console.log('Started');

var Elm = require('./build/elm');

var app = Elm.Main.worker();

app.ports.dbg.subscribe(function(word) {
	console.log('debug: ', word);
});

setTimeout(function() {
	app.ports.started.send(true);
}, 0);
