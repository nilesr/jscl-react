(defcomponent (search-input nil) (set-state state props)
 (render
   "div"
   (object "className" "component-search-input" "key" "outer")
   ("div" (object "key" "inner")
    ("input" (object "onChange" (getobj "textChange" props))))))
