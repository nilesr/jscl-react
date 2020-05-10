(defun format-count (val)
  (if (zerop val)
    "Zero"
    val))

(defun badge-classes (val)
  (#j:String:prototype:concat:call
   "badge m-2 badge-"
   (if (zerop val)
     "warning"
     "primary")))

(defcomponent (counter nil) (s s2 props)
  (declare (ignore s) (ignore s2))
  (let* ((counter (getobj "counter" props))
         (val (getobj "value" counter)))
    (#j:console:log counter)
    (#j:console:log val)
    (render "div" #()
            ("div" (object "className" "row")
             ("div" (object "className" "col-md-1")
              ("span" (object "className" (badge-classes val) "style" (object "fontSize" 24))
               (format-count val)))
             ("div" (object "className" "col-md-4")
              ("button" (object
                          "className" "btn btn-secondary"
                          "onClick" (lambda (e) (funcall (getobj "onIncrement" props) counter)))
               ("i" (object "className" "fa fa-plus-circle" "aria-hidden" "true")))
              ("button" (object
                          "className" "btn btn-info m-2"
                          "onClick" (lambda (e) (funcall (getobj "onDecrement" props) counter))
                          "disabled" (if (zerop val) "disabled" ""))
               ("i" (object "className" "fa fa-minus-circle" "aria-hidden" "true")))
              ("button" (object
                          "className" "btn btn-danger"
                          "onClick" (lambda (e) (funcall (getobj "onDelete" props) (getobj "id" counter))))
               ("i" (object "className" "fa fa-trash-o" "aria-hidden" "true"))))))))
