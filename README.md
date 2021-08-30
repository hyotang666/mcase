# MCASE 0.0.0
## What is this?
Control frow macros with case comprehensiveness checking.

## Usage

```lisp
* (deftype state ()
    '(member :a :b :c))
STATE

* (mcase:mcase state :hoge
    (:a "A")
    (:b "B"))
=> ERROR Missing member (:C) :of STATE
```
For details, see [spec file.](spec/mcase.lisp)

## From developer

### Product's goal

### License
Public domain.

### Developed with
SBCL

### Tested with

## Installation

