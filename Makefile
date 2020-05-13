all: demo-app.js counter-app/counter-app.js emoji-search/emoji-search.js
clean:
	rm demo-app.js counter-app/counter-app.js emoji-search/emoji-search.js
jscl:
	git submodule init
	git submodule update
demo-app.js: jscl demo-app.lisp jscl-react.lisp
	$(MAKE) build
counter-app/counter-app.js: jscl jscl-react.lisp $(wildcard counter-app/*.lisp) $(wildcard counter-app/components/*.lisp)
	$(MAKE) build
emoji-search/emoji-search.js: jscl jscl-react.lisp $(wildcard emoji-search/*.lisp)
	$(MAKE) build
build: jscl build.lisp
	cd jscl && env SOURCE_DATE_EPOCH=$(shell date +%s) sbcl --load ../build.lisp --eval '(exit)'

.PHONY: all clean build
