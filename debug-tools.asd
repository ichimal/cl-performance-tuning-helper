(in-package :cl-user)

(defpackage #:debug-tools-asd
  (:use :cl :asdf) )

(in-package #:debug-tools-asd)

(defsystem debug-tools
  :name "debug-tools"
  :version "0.2.3"
  :maintainer "SUZUKI Shingo"
  :author "SUZUKI Shingo"
  :licence "MIT"
  :description "simple debug tools"
  :components ((:file "dbgtl")) )


