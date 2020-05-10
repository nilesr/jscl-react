(defcomponent (navbar nil) (s s2 props)
  (declare (ignore s) (ignore s2))
  (render
    "nav"
    (object "className" "navbar navbar-light bg-light")
    ("div" (object "className" "navbar-brand")
     ("i" (object "className" "fa fa-shopping-cart fa-lg m-2" "aria-hidden" "true"))
     ("span" (object "className" "badge badge-pill badge-info m-2" "style" (object "width" 50))
      (getobj "totalCounters" props))
     "Items")))

