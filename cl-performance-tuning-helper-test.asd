(in-package :cl-user)

(defpackage #:debug-tools-asd
  (:use :cl :asdf) )

(in-package #:debug-tools-asd)

(defsystem debug-tools-test
  :depends-on (:debug-tools :rt)
  :components ((:file "dbgtl-test")) )

(defmethod perform ((op test-op) (compo (eql (find-system :debug-tools-test))))
  (declare (ignore op compo))
  (funcall (intern "DO-TESTS" :rt)) )

