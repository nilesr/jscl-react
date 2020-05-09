all: demo-app.js
clean:
	rm demo-app.js
jscl:
	git submodule init
	git submodule update
demo-app.js: jscl demo-app.lisp jscl-react.lisp
	cd jscl && env SOURCE_DATE_EPOCH=$(shell date +%s) sbcl --load ../build.lisp --eval '(exit)'

.PHONY: all clean
