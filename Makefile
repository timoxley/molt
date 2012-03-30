OLD		= ls -l release | grep .js | sed -r 's/.+\s(\S+)/\1/'
NAME	= ls src | sed -r 's/ender\.js|package\.json|\s+//' | sed -nr 's/(.+)\.js/\1/p'
VERSION	= grep -m 1 Version src/\`${NAME}\`.js | sed -r 's/.*:\s*(.+)/\1/'
W		= ls lib | grep W

all: lint minify

lint:
	@jshint src/`${NAME}`.js --config config/jshint.json

minify:
	@rm -f `${OLD}`
	@rm -f `${OLD}`
	@uglifyjs -nc src/`${NAME}`.js > release/`${NAME}`-`${VERSION}`.min.js
	@cat lib/`${W}` release/`${NAME}`-`${VERSION}`.min.js > release/`${NAME}`-`${VERSION}`.W.min.js

instdeps:
	@npm install jshint -g
	@npm install uglify-js -g
