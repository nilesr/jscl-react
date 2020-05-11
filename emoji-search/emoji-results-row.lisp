(defcomponent (emoji-results-row nil) (s s2 props)
  (declare (ignore s) (ignore s2))
  (let* ((code-point-hex (#j:Number:prototype:toString:call (#j:String:prototype:codePointAt:call (getobj "symbol" props) 0) 16))
         (src (#j:String:prototype:concat:call "http://cdn.jsdelivr.net/emojione/assets/png/" code-point-hex ".png")))
    (render
      "div"
      (object "className" "component-emoji-result-row copy-to-clipboard"
              "data-clipboard-text" (getobj "symbol" props))
      ("img" (object "alt" (getobj "title" props) "src" src))
      ("span" (object "className" "title") (getobj "title" props))
      ("span" (object "className" "info") "Click to copy emoji"))))
