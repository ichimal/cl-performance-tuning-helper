A simple debug tools for Common Lisp
====================================

## APIs:
### Function `CLOAD`:
load a file after compile.

e.g. `(dbgtl:cload "src")` for compile and load "`src.lisp`".

### Function `ASMOUT`:
save `DISASSEMBLE` result into a file.

e.g. `(dbgtl:asmout 'dbgtl:asmout)` saves `DISASSEMBLE` result into "`asmout.asm`" file.

### Macro `PERFORMANCE`:
simple performance checker.

e.g. 1 `(dbgtl:performance 100 debugger-p (some-function args...))`

tries to eval `SOME-FUNCTION` 100 times with specified args.

After all, displays execution information by `TIME` macro.

`DBGTL:PERFORMANCE` returns t if all eval has been done successfully.

When a condition has been signaled;

- when `debugger-p` is `nil`:  
  `DEBGTL:PERFORMANCE` returns `nil`.
- when `debugger-p` is non-`nil`:  
  invoke debugger for any kind of conditions.

e.g. 2

target function also able to access current-num-repeats.

        (let ((max 5))
          (dbgtl:performance (count max) nil
            (format t "~&~d of ~d~%" count max) ))
        ;;; performance test for FORMAT 5 times
        ;;;   do (FORMAT T "~&~d of ~d~%" COUNT MAX)
        0 of 5
        1 of 5
        2 of 5
        3 of 5
        4 of 5
        (and implementation dependant TIME macro result)
        ; => T

## LICENSE:
debug-tools is under MIT license.

