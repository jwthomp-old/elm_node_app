console.log('Node Elm started');

var Elm = require('./build/elm');

var app = Elm.Main.worker();

app.ports.dbg.subscribe(function(word) {
	console.log('debug: ', word);
});
