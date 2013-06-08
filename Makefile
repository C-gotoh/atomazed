default: build run

clean:
	@[[ ! -e game.love ]] || rm game.love
	@[[ ! -e pkg ]] || rm -r pkg		

build: clean
	@zip -r -0 game.love data/*
	@cd src/ && zip -r ../game.love *

run: build
	@love game.love
