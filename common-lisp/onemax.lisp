(defpackage :ga-performance
  (:use :cl))

(defparameter iterations 100000)
(defparameter maxlength 32768)

;; onemax
(do ((len 16 (ash len 1)))
    ((> len maxlength))
  (let ((arr (make-array len :element-type '(mod 2))))
    (dotimes (l len)
      (setf (aref arr l) (random 2)))
    
    (defparameter start (get-internal-run-time))
    (dotimes (k iterations)
      (dotimes (l len)
        (count 1 arr)))
    
    (defparameter end (get-internal-run-time))

    (format t "clisp-simple_bit_vector, ~a, ~8$~%" len (float (/ (- end start) 1000)))
    ))
