(defcomponent (counters nil) (s s2 props)
  (declare (ignore s) (ignore s2))
  (obj-destructure props (|onReset|
                          |onIncrement|
                          |onDelete|
                          |onDecrement|
                          |counters|
                          |onRestart|)
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
