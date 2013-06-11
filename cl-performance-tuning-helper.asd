(in-package :cl-user)

(defpackage #:cl-performance-tuning-helper-asd
  (:use :cl :asdf) )

(in-package #:cl-performance-tuning-helper-asd)

(defsystem cl-performance-tuning-helper
  :name "cl-performance-tuning-helper"
  :version "0.3.0"
  :maintainer "SUZUKI Shingo"
  :author "SUZUKI Shingo"
  :licence "MIT"
  :description "A simple performance tuning helper tool box for Common Lisp"
  :components ((:file "cl-performance-tuning-helper")) )

(defmethod perform ((op test-op)
                    (compo (eql (find-system :cl-performance-tuning-helper))) )
  (declare (ignore op compo))
  (operate 'load-op :cl-performance-tuning-helper-test)
  (operate 'test-op :cl-performance-tuning-helper-test :force t) )

