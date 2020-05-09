(load "jscl.lisp")
(jscl:bootstrap)

(jscl:compile-application
  (list "app/app.lisp")
  "app.js")

