(#j:console:log "Loading demo-app.lisp...")

(defcomponent (btn 0) (set-state state props)
  (let ((handler (lambda (&rest whatever)
                   (funcall set-state (1+ state)))))
    (render
      "button"
       (object "onClick" handler)
       "Hello, World: "
       state)))

(defcomponent (todo-list '("" ("Some Items" "Some Items"))) (set-state state props &rest whatever)
  (destructuring-bind
    (temp items)
    state
    (let ((onchange (lambda (evt) (funcall set-state (list (getobj "value" (getobj "target" evt)) items))))
          (add (lambda (event)
                 (#j:window:preventDefault event)
                 (funcall set-state (list "" (cons temp items)))))
          (make-deleter (lambda (i)
                 (lambda (evt)
                   (funcall set-state (list temp (remove-at-index i items)))))))
      (render "div" #()
        ("ul"
         #()
         (apply #'vector
                (loop for item in items
                      for i from 0
                      collect (render
                                "li"
                                 (object "key" i)
                                 ("button" (object "onClick" (funcall make-deleter i) "style" (object "marginRight" "10px")) "x")
                                 item))))
        ("form"
         (object "onSubmit" add)
         ("input" (object "value" temp "onChange" onchange))
         ("button" (object "onClick" add) "Add item"))))))

(mount
  "root"
  (render
    "div"
    #()
    ("div" (object "id" "thing")
      "This is a text node"
      ("br")
      ((btn) (object "props" "here")))
    ("h2" #() "Todo list!")
    ((todo-list))))
