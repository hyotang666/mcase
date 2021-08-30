(in-package :cl-user)

(defpackage :mcase
  (:use :cl)
  (:export "MCASE" "EMCASE"))

(in-package :mcase)

(defun check-exhaust (type clauses)
  (let* ((member (millet:type-expand type))
         (targets
          (loop :for (target) :in clauses
                :if (atom target)
                  :collect target
                :else
                  :append target))
         (missings (set-difference (cdr member) targets))
         (unknowns (set-difference targets (cdr member))))
    (assert (typep member '(cons (eql member))) ()
      "~S Must defined as MEMBER type but ~S" type member)
    (assert (null missings) () "Missing member ~S of ~S" missings type)
    (assert (null unknowns) () "Unknown member ~S of ~S" unknowns member)))

(defmacro mcase (type <target> &body clauses)
  (check-exhaust type clauses)
  `(case ,<target> ,@clauses))

(defmacro emcase (type <target> &body clauses)
  (check-exhaust type clauses)
  `(ecase ,<target> ,@clauses))