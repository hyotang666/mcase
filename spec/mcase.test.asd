; vim: ft=lisp et
(in-package :asdf)
(defsystem "mcase.test"
  :version
  "0.0.0"
  :depends-on
  (:jingoh "mcase")
  :components
  ((:file "mcase"))
  :perform
  (test-op (o c) (declare (special args))
   (apply #'symbol-call :jingoh :examine :mcase args)))