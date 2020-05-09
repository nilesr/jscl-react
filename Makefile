all: demo-app.js
clean:
	rm demo-app.js
jscl:
	git submodule init
	git submodule update
demo-app.js: jscl demo-app.lisp jscl-react.lisp
	cd jscl; sbcl --script ../build.lisp

.PHONY: all clean
