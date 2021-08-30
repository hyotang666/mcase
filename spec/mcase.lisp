(defpackage :mcase.spec
  (:use :cl :jingoh :mcase))
(in-package :mcase.spec)
(setup :mcase)

(requirements-about MCASE :doc-type function)

;;;; Description:
; A thin wrapper for CL:CASE to check MEMBER comprehensiveness in macro expansion time.

#+syntax (MCASE type <target> &body clause*) ; => result

;;;; Arguments and Values:

; type := type-specifer, otherwise implementation dependent condition.
#?(mcase "not type specifier" :dummy) :signals condition
,:lazy t

; <target> := Expression to generate target value.

; clause* := Same with CL:CASE.

; result := T.

;;;; Affected By:
; none

;;;; Side-Effects:
; none

;;;; Notes:

;;;; Exceptional-Situations:
; When type specifier is not expanded to (MEMBER ...) an error is signaled.
#?(mcase (unsigned-byte 8) :dummy) :signals error
,:lazy t

; Ordinary otherwise clause is invalid because in such case you should use CASE.
#?(mcase (member 0 1 2) :dummy
    ((0 1 2) :yes)
    (otherwise :no))
:signals error
,:lazy t

; One exceptional situation is OTHERWISE in the MEMBER.
#?(mcase (member 0 1 2 otherwise) :dummy
    ((0 1 2) :yes)
    (otherwise :no))
=> :NO

;;;; Examples:
#?(deftype state () '(member :a :b :c)) => STATE

#?(mcase state :dummy (:a "Missing :b and :c members")) :signals error
,:lazy t

#?(mcase state :dummy ((:a :b :c) "Works fine.")) => NIL

#?(mcase state :dummy
    ((:a :b :c) "Fine but")
    (:d "Ooops! Unknown member is found!"))
:signals error
,:lazy t

(requirements-about EMCASE :doc-type function)

;;;; Description:
; A thin wrapper for CL:ECASE to check MEMBER comprehensiveness in macro expansion time.

#+syntax (EMCASE type <target> &body clauses) ; => result

; type := type-specifer, otherwise implementation dependent condition.
#?(emcase "not type specifier" :dummy) :signals condition
,:lazy t

; <target> := Expression to generate target value.

; clause* := Same with CL:ECASE.

; result := T.

;;;; Affected By:
; none

;;;; Side-Effects:
; none

;;;; Notes:

;;;; Exceptional-Situations:
; When type specifier is not expanded to (MEMBER ...) an error is signaled.
#?(emcase (unsigned-byte 8) :dummy) :signals error
,:lazy t

;;;; Examples:
#?(emcase state :dummy (:a "Missing :b and :c members")) :signals error
,:lazy t

#?(emcase state :dummy ((:a :b :c) "Works fine.")) :signals error

#?(emcase state :dummy
    ((:a :b :c) "Fine but")
    (:d "Ooops! Unknown member is found!"))
:signals error
,:lazy t

