(eval-when (:load-toplevel :compile-toplevel :execute)
  (in-package #:debug-tools-asd) )

(defpackage :debug-tools
  (:nicknames :dbgtl)
  (:use :cl)
  (:export #:cload #:asmout #:performance #:trash-outputs) )

(eval-when (:load-toplevel :compile-toplevel :execute)
  (in-package :debug-tools) )

(defun cload (path)
  "load after compile a file"
  (multiple-value-bind (truename warnings-p failure-p) (compile-file path)
    (declare (ignore truename warnings-p))
    (unless failure-p
      (load path) )))

(defun asmout (fsym &optional path)
  "output DISASSEMBLE result into a file"
  (declare (type symbol fsym)
           (ftype (function (symbol) boolean) asmout) )
  (let ((eff-path (or path (string-downcase (format nil "~a.asm" fsym)))))
    (format t "~&try to output disassemble result into ~a ..." eff-path)
    (with-open-file (fn eff-path
                        :direction :output
                        :if-does-not-exist :create
                        :if-exists :supersede )
      (let ((*standard-output* fn))
        (disassemble fsym) )))
  (format t " done.~%")
  t )

(defmacro performance (num-repeats debugger-p
                       (func &rest args)
                       &environment env )
  "do performance test with specified arguments

usage: (performance num-repeats debugger-p (function &rest args))

num-repeats: designates a number of repeats in positive integer.
If you want to reference current repeat count from testing function,
you should specify num-repeats as following format:
  (count-variable positive-integer).

debugger-p: designate enable to call debugger for ANY conditions.

function: a symbol of function or a lambda expression.

e.g.
(let ((max 5))
  (dbgctl:performance (i max) nil (format t \"SAMPLE: ~d of ~d~%\" i max)) )
=> t
---- 
;;; performance test for FORMAT MAX times
;;;   do (FORMAT T \"SAMPLE: ~d of ~d~%\" I MAX)
SAMPLE: 0 of 5
SAMPLE: 1 of 5
SAMPLE: 2 of 5
SAMPLE: 3 of 5
SAMPLE: 4 of 5

(and following platform dependant output of TIME function)
"
  (declare (ignorable env))
  (multiple-value-bind (eff-num iter-var)
      (etypecase num-repeats
        ((or (integer (0) *) symbol)
         (values num-repeats (gensym)) )
        ((cons symbol (cons (or (integer (0) *) symbol)))
         (values (cadr num-repeats) (car num-repeats)) ))
    `(progn
       (format t "~&;;; performance test for ~s ~d times~%~
               ;;;   do (~s~{ ~s~})~%"
               ',func ,eff-num ',func ',args )
       (handler-case
         (progn
           (time (dotimes (,iter-var ,eff-num)
                   (declare (ignorable ,iter-var))
                   (,func ,@args)) )
           t )
         ;; simple condition handler
         (t (cond)
            (if ,debugger-p
              (error cond)
              (format t "~&~%caught condition: ~s.~%" cond) )))) ))

(defmacro trash-outputs (&body body)
  "trash system stream outputs:
*standard-output*,
*error-output*,
and *trace-output*."
  (let ((sos (gensym)))
    `(let* ((,sos (make-string-output-stream))
            (*standard-output* ,sos)
            (*error-output* ,sos)
            (*trace-output* ,sos) )
       ,@body )))

