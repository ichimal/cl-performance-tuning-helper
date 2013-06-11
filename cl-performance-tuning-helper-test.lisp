(eval-when (:load-toplevel :compile-toplevel :execute)
  (in-package #:cl-performance-tuning-helper-asd) )

(defpackage :cl-performance-tuning-helper-test
  (:use :cl :pth :rt)
  (:import-from :rt #:*compile-tests* #:*expected-failures*) )

(eval-when (:load-toplevel :compile-toplevel :execute)
  (in-package :cl-performance-tuning-helper-test) )

(deftest performance.1
  (trash-outputs (performance 100 nil (identity nil)))
  t )

(deftest performance.2
  (trash-outputs
    (let ((stack nil)
          (max 10)
          (expected-stack '(9 8 7 6 5 4 3 2 1 0)) )
      (values (performance (i max) nil (push i stack))
              (equal stack expected-stack) )))
  t t )

(deftest performance.3
  (trash-outputs (performance 1 t (identity nil)) )
  t )

(deftest performance.4
  (trash-outputs
    (handler-case
      (performance 1 t (error 'condition))
      (t (cond)
         (eq (type-of cond) 'condition) )) )
  t )


