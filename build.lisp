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

(when (find-package 'ql) ; only compile emoji-search if we have quicklisp available
  (jscl:compile-application
    (list
      "../jscl-react.lisp"
      "../emoji-search/filter-emoji.lisp"
      "../emoji-search/emoji-results-row.lisp"
      "../emoji-search/emoji-results.lisp"
      "../emoji-search/search-input.lisp"
      "../emoji-search/header.lisp"
      "../emoji-search/app.lisp")
    "../emoji-search/emoji-search.js"))

