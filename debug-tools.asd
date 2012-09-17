(in-package :cl-user)

(defpackage #:debug-tools-asd
  (:use :cl :asdf) )

(in-package #:debug-tools-asd)

(defsystem debug-tools
  :name "debug-tools"
  :version "0.3.0"
  :maintainer "SUZUKI Shingo"
  :author "SUZUKI Shingo"
  :licence "MIT"
  :description "simple debug tools"
  :components ((:file "dbgtl")) )

(defmethod perform ((op test-op) (compo (eql (find-system :debug-tools))))
  (declare (ignore op compo))
  (operate 'load-op :debug-tools-test)
  (operate 'test-op :debug-tools-test :force t) )

