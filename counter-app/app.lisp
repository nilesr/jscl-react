(#j:console:log "Loading counter-app/app.lisp...")

(defcomponent (app (object "counters" (vector (object "id" 1 "value" 0)
                                              (object "id" 2 "value" 0)
                                              (object "id" 3 "value" 0)
                                              (object "id" 4 "value" 0))))
              (set-state state props)
  (let* ((counters (getobj "counters" state))
         (totalCounters (length (remove-if (lambda (c) (zerop (getobj "value" c))) counters)))
         (handleIncrement
           (lambda (c)
             (let* ((i (#j:Array:prototype:indexOf:call counters c))
                    (newcounters (setobj i (setobj "value" (1+ (getobj "value" c)) c) counters)))
               (funcall set-state (object "counters" newcounters)))))
         (handleDecrement
           (lambda (c)
             (let* ((i (#j:Array:prototype:indexOf:call counters c))
                    (newcounters (setobj i (setobj "value" (1- (getobj "value" c)) c) counters)))
               (funcall set-state (object "counters" newcounters)))))
         (handleReset
           (lambda (event)
             (funcall set-state (object "counters" (apply #'vector (loop for c across counters collect (setobj "value" 0 c)))))))
         (handleDelete
           (lambda (i)
             (funcall set-state (object "counters" (apply #'vector (loop for c across counters when (not (= (getobj "id" c) i)) collect c))))))
         (handleRestart (lambda (event) (#j:window:location:reload))))
     (render
       "div"
       #()
       ((navbar) (object "totalCounters" totalCounters))
       ("main" (object "className" "container")
        ((counters) (object "counters" counters
                            "onReset" handleReset
                            "onIncrement" handleIncrement
                            "onDecrement" handleDecrement
                            "onDelete" handleDelete
                            "onRestart" handleRestart))
        "(this is the lisp version)"))))

(mount "root" (render (app)))
