NAME = atomazed

default: build run

clean:
	@[[ ! -e game.love ]] || rm game.love
	@[[ ! -e pkg ]] || rm -r pkg

build: clean
	@zip -r -0 game.love data/*
	@cd src/ && zip -r ../game.love *

run: build
	@love game.love
deploy: build
	@cat love.exe game.love > deploy/love-0.8.0-win-x86/$(NAME).exe
	@7z a deploy/builds/$(NAME)-win.zip deploy/love-0.8.0-win-x86/*
	@mv game.love deploy/builds/$(NAME).love
	@cat /usr/bin/love deploy/builds/$(NAME).love > deploy/builds/$(NAME)-linux
	@cp deploy/builds/$(NAME).love deploy/$(NAME).app/Contents/Resources/
	@7z a deploy/builds/$(NAME).osx.zip deploy/$(NAME).app/
