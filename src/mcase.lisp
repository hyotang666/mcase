(in-package :cl-user)

(defpackage :mcase
  (:use :cl)
  (:export "MCASE" "EMCASE"))

(in-package :mcase)

(defun check-exhaust (type clauses)
  (let ((member (millet:type-expand type)))
    (assert (typep member '(cons (eql member))) ()
      "~S Must defined as MEMBER type but ~S" type member)
    (let* ((targets
            (loop :for (target) :in clauses
                  :if (atom target)
                    :collect target
                  :else
                    :append target))
           (missings (set-difference (cdr member) targets))
           (unknowns (set-difference targets (cdr member))))
      (assert (null missings) () "Missing member ~S of ~S" missings type)
      (assert (null unknowns) () "Unknown member ~S of ~S" unknowns member))))

(defmacro mcase (type <target> &body clauses)
  (check-exhaust type clauses)
  `(case ,<target> ,@clauses))

(defmacro emcase (type <target> &body clauses)
  (check-exhaust type clauses)
  `(ecase ,<target> ,@clauses))

(defun pprint-mcase-clause (output clause &rest noise)
  (declare (ignore noise))
  (funcall
    (formatter
     #.(concatenate 'string "~:<" ; pprint-logical-block.
                    "~^~W~1I~^ ~_" ; targets
                    "~@{" ; iterate for clause body.
                    "~W~^ ~_" ; each form.
                    "~}" ; end of iter.
                    "~:>"))
    output clause))

(defun pprint-mcase (output exp)
  (funcall
    (formatter
     #.(concatenate 'string "~:<" ; pprint-logical-block.
                    "~W~^~1I ~@_" ; operator.
                    "~W~^ ~@_" ; type
                    "~W~^ ~_" ; <target>
                    "~@{" ; iterate clauses.
                    "~/mcase:pprint-mcase-clause/~^ ~_" ; each clause.
                    "~}" ; end of iter.
                    "~:>"))
    output exp))

(set-pprint-dispatch '(cons (member mcase emcase)) 'pprint-mcase)
