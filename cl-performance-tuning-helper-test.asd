(in-package :cl-user)

(defpackage #:cl-performance-tuning-helper-asd
  (:use :cl :asdf) )

(in-package #:cl-performance-tuning-helper-asd)

(defsystem cl-performance-tuning-helper-test
  :depends-on (:cl-performance-tuning-helper :rt)
  :components ((:file "cl-performance-tuning-helper-test")) )

(defmethod perform ((op test-op)
                    (compo (eql (find-system
                                  :cl-performance-tuning-helper-test ))))
  (declare (ignore op compo))
  (funcall (intern "DO-TESTS" :rt)) )

