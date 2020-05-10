all: demo-app.js counter-app/counter-app.js
clean:
	rm demo-app.js
jscl:
	git submodule init
	git submodule update
demo-app.js: jscl demo-app.lisp jscl-react.lisp
	$(MAKE) build
counter-app/counter-app.js: jscl counter-app/app.lisp counter-app/components/navbar.lisp counter-app/components/counters.lisp counter-app/components/counter.lisp
	$(MAKE) build
build:
	cd jscl && env SOURCE_DATE_EPOCH=$(shell date +%s) sbcl --load ../build.lisp --eval '(exit)'

.PHONY: all clean build
