(defcomponent (app (object "filteredEmoji" (filter-emoji "" 20))) (set-state state props)
  (let ((handle-search-change (lambda (evt)
                                (funcall set-state
                                         (object "filteredEmoji"
                                                 (filter-emoji (getobj "value" (getobj "target" evt)) 20))))))
    (render
      "div"
      #()
      ((header))
      ((search-input) (object "textChange" handle-search-change))
      ((emoji-results) (object "emojiData" (getobj "filteredEmoji" state))))))

(mount "root" (render (app)))
