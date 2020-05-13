(defcomponent (search-input nil) (set-state state props)
 (render
   "div"
   (object "className" "component-search-input")
   ("div" #()
    ("input" (object "onChange" (getobj "textChange" props))))))
