(#j:window:construct #j:ClipboardJS ".copy-to-clipboard")

(defcomponent (emoji-results nil) (s s2 props)
  (declare (ignore s) (ignore s2))
  (render
    "div"
    (object "className" "component-emoji-results")
    (apply #'vector (loop for emoji-data in (getobj "emojiData" props)
                          collect (render
                                    (emoji-results-row)
                                    (object "key" (cdr (assoc :title emoji-data))
                                            "symbol" (cdr (assoc :symbol emoji-data))
                                            "title" (cdr (assoc :title emoji-data))))))))
