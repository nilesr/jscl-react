(defcomponent (counters nil) (s s2 props)
  (declare (ignore s) (ignore s2))
  (let ((onReset (getobj "onReset" props))
        (onIncrement (getobj "onIncrement" props))
        (onDelete (getobj "onDelete" props))
        (onDecrement (getobj "onDecrement" props))
        (counters (getobj "counters" props))
        (onRestart (getobj "onRestart" props)))
    (render "div" #()
      ("button" (object "className" "btn btn-success m-2"
                        "onClick" onReset
                        "disabled" (if (zerop (length counters)) "disabled" ""))
       ("i" (object "className" "fa fa-refresh" "aria-hidden" "true")))
      ("button" (object "className" "btn btn-primary m-2"
                        "onClick" onRestart
                        "disabled" (if (zerop (length counters)) "" "disabled"))
       ("i" (object "className" "fa fa-recycle" "aria-hidden" "true")))
      (apply #'vector (loop for counter across counters
                             collect (render (counter) (object "key" (getobj "id" counter)
                                                               "counter" counter
                                                               "onIncrement" onIncrement
                                                               "onDecrement" onDecrement
                                                               "onDelete" onDelete)))))))
