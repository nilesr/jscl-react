(defcomponent (header nil) (s s2 props)
  (declare (ignore s) (ignore s2) (ignore props))
  (render
    "header"
    (object "className" "component-header")
    ("img" (object "src" "http://cdn.jsdelivr.net/emojione/assets/png/1f638.png"
                   "width" "32"
                   "height" "32"
                   "alt" ""))
    "Emoji Search"
    ("img" (object "src" "http://cdn.jsdelivr.net/emojione/assets/png/1f63a.png"
                   "width" "32"
                   "height" "32"
                   "alt" ""))))
