(load "jscl.lisp")
(jscl:bootstrap)

(jscl:compile-application
  (list
    "../jscl-react.lisp"
    "../demo-app.lisp")
  "../demo-app.js")

(jscl:compile-application
  (list
    "../jscl-react.lisp"
    "../counter-app/components/navbar.lisp"
    "../counter-app/components/counters.lisp"
    "../counter-app/components/counter.lisp"
    "../counter-app/app.lisp")
  "../counter-app/counter-app.js")

