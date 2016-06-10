"use strict";

const express = require('express');
const expressApp = express();

console.log('Node Elm started');

var Elm = require('./build/elm');

var app = Elm.Main.worker();

app.ports.dbg.subscribe(function(word) {
	console.log('debug: ', word);
});

app.ports.binder.subscribe(function(data) {
	console.log('bindings: ', data.bindings);

	let i;
	for (i = 0; i < data.bindings.length; i++) {
		let binding = data.bindings[i];
		if (binding.method === 'GET') {
			expressApp.get(binding.route, function(req, res) {
				app.ports.recv.send([req.url, res]);
			});
		}
	}
	expressApp.listen(data.prt, console.log('Listning on port: ', data.prt));

	app.ports.recv.send(['hi', { a: 1 }]);
});
