all: build run

build:
	elm make Main.elm --output ./build/elm.js

run:
	node app.js

.PHONY: build run all
