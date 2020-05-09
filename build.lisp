(load "jscl.lisp")
(jscl:bootstrap)

(jscl:compile-application
  (list
    "../jscl-react.lisp"
    "../demo-app.lisp")
  "../demo-app.js")
