(#j:window:construct #j:ClipboardJS ".copy-to-clipboard")

(defcomponent (emoji-results nil) (s s2 props)
  (declare (ignore s) (ignore s2))
  (render
    "div"
    (object "className" "component-emoji-results")
    (apply #'vector (loop for emoji-data in (getobj "emojiData" props)
                          collect (render
                                    (emoji-results-row)
                                    (object "key" (assoc-val :title emoji-data)
                                            "symbol" (assoc-val :symbol emoji-data)
                                            "title" (assoc-val :title emoji-data)))))))
