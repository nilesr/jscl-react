(defpackage :common-lisp-user)
(#j:console:log "Loading app.lisp...")

(defun get-element-by-id (id) (#j:document:getElementById id))
(defun react-render (&rest stuff) (apply #j:ReactDOM:render stuff))
(defun react-create-element (&rest args) (apply #j:React:createElement args))
(defun alert (&rest args) (apply #j:window:alert args))
(defun object (&rest l) (apply #j:window:lispToJs l)) ; TODO reader macro
(defun getobj (key obj) (#j:window:getObj key obj))
(defun to-list (vec) (loop for item across vec collect item))
(defun use-state (default) (#j:React:useState default))
(defun vec-push (vec new-item) (apply #'vector (cons (to-list vec) new-item)))

(defmacro render (&body arguments)
  (let ((render-help
          (lambda (l rh)
            (if (symbolp l) l
            `(react-create-element
              ,(car l)
              ,(cadr l)
              ,@(loop for child in (cddr l)
                      collect (cond
                                ((stringp child) child)
                                ((symbolp child) child)
                                ((listp child) 
                                 (let ((c (car child)))
                                   (cond
                                     ((stringp c) (funcall rh child rh))
                                     ((listp c)
                                      (if (eq (car c) 'jscl::oget)
                                        child
                                        (funcall rh child rh)))
                                     (t child))))
                                (t (funcall rh child rh)))))))))
    `(vector
      ,@(loop for form in arguments
              collect (funcall render-help form render-help)))))

(defmacro defcomponent ((name initial-state) args &body body)
  `(defun ,name () (#j:window:makeComponent ,initial-state (lambda ,args ,@body))))

(defun mount (root-id el)
  (let ((domContainer (get-element-by-id root-id)))
    (react-render el domContainer)))

(defun remove-at-index (idx l)
  (loop for i from 0 for item in l when (not (= i idx)) collect item))




(defcomponent (btn 0) (set-state state props)
  (let ((handler (lambda (&rest whatever)
                   (funcall set-state (1+ state)))))
    (render
      ("button"
       (object "onClick" handler)
       "Hello, World: "
       state))))

(defcomponent (todo-list '("" ())) (set-state state props &rest whatever)
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
      (render
        ("ul"
         #()
         (apply #'vector
                (loop for item in items
                      for i from 0
                      collect (render
                                ("li"
                                 (object "key" i)
                                 ("button" (object "onClick" (funcall make-deleter i) "style" (object "marginRight" "10px")) "x")
                                 item)))))
        ("form"
         (object "onSubmit" add)
         ("input" (object "value" temp "onChange" onchange))
         ("button" (object "onClick" add) "Add item"))))))

(mount
  "root"
  (render
    ("h1" #() "Hello, World!")
    ("div" (object "id" "thing")
      "This is a text node"
      ("br")
      ((btn) (object "props" "here")))
    ((todo-list))))
