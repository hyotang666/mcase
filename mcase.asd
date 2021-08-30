; vim: ft=lisp et
(in-package :asdf)
(defsystem "mcase"
  :version
  "1.2.1"
  :depends-on
  (
   "millet"     ; Wrapper for implementation dependent utilities.
   )
  :pathname
  "src/"
  :components
  ((:file "mcase"))
  :description "Control frow macros with case comprehensiveness checking."
  :author "SATO Shinichi"
  :license "Public domain"
  :source-control (:git "git@github.com:hyotang666/mcase")
  :bug-tracker "https://github.com/hyotang666/mcase/issues")

;;; These forms below are added by JINGOH.GENERATOR.
;; Ensure in ASDF for pretty printings.
(in-package :asdf)
;; Enable testing via (asdf:test-system "mcase").
(defmethod component-depends-on ((o test-op) (c (eql (find-system "mcase"))))
  (append (call-next-method) '((test-op "mcase.test"))))
;; Enable passing parameter for JINGOH:EXAMINER via ASDF:TEST-SYSTEM.
(defmethod operate :around
           ((o test-op) (c (eql (find-system "mcase")))
            &rest keys
            &key ((:compile-print *compile-print*))
            ((:compile-verbose *compile-verbose*)) &allow-other-keys)
  (flet ((jingoh.args (keys)
           (loop :for (key value) :on keys :by #'cddr
                 :when (find key '(:on-fails :subject :vivid) :test #'eq)
                 :collect key
                 :and
                 :collect value :else
                 :when (eq :jingoh.verbose key)
                 :collect :verbose
                 :and
                 :collect value)))
    (let ((args (jingoh.args keys)))
      (declare (special args))
      (call-next-method))))
;; Enable importing spec documentations.
(let ((system (find-system "jingoh.documentizer" nil)))
  (when system
    (load-system system)
    (defmethod perform :after ((o load-op) (c (eql (find-system "mcase"))))
      (with-muffled-conditions (*uninteresting-conditions*)
        (handler-case (symbol-call :jingoh.documentizer :import c)
                      (error (condition)
                             (warn "Fails to import documentation of ~S.~%~A"
                                   (coerce-name c)
                                   (princ-to-string condition))))))))
