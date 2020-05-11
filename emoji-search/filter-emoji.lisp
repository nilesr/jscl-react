(eval-when (:compile-toplevel)
  (ql:quickload "cl-json"))
(defmacro read-the-file ()
  (json:bind-custom-vars (:array-type 'vector)
    (let* ((in (open (merge-pathnames "../emoji-search/emojiList.json" *default-pathname-defaults*)))
           (loaded (cl-json:decode-json in)))
      (close in)
      `(quote ,loaded))))

(defvar *emoji-list* (read-the-file))

(defun downcase (str)
  (#j:String:prototype:toLowerCase:call str))

;; Using javascript for string contains cuts the time for a search down by a factor of 100
(defun contains (needle haystack)
  (>= (#j:String:prototype:indexOf:call haystack needle) 0))

(defun filter-emoji (search-text max-results)
  (let ((downcased-search-text (downcase search-text)))
    (loop
      for i from 0 to max-results
      for elem across (remove-if-not
                        (lambda (emoji)
                          (or
                            (contains downcased-search-text
                                      (downcase (cdr (assoc :title emoji))))
                            (contains search-text
                                      (cdr (assoc :keywords emoji)))))
                        *emoji-list*)
      collect elem)))
