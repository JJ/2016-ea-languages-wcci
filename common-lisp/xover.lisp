(defpackage :ga-performance
  (:use :cl))

(defparameter iterations 100000)
(defparameter maxlength 32768)

;; crossover
(do ((len 16 (ash len 1)))
    ((> len maxlength))
  (let ((arr1 (make-array len :element-type '(mod 2)))
        (arr2 (make-array len :element-type '(mod 2))))
    (dotimes (l len)
      (setf (aref arr1 l) (random 2))
      (setf (aref arr2 l) (random 2)))    

    (defparameter start (get-internal-run-time))
    (dotimes (k iterations)
      (let* ((point1 (random len))
             (point2 (random len))
             (mn (min point1 point2))
             (mx (max point1 point2)))
        (let ((newarr1 (concatenate 'vector (subseq arr1 0 mn) (subseq arr2 mn mx) (subseq arr1 mx)))
              (newarr2 (concatenate 'vector (subseq arr2 0 mn) (subseq arr1 mn mx) (subseq arr2 mx)))))))
    (defparameter end (get-internal-run-time))

    (format t "clisp-simple_bit_vector, ~a, ~8$~%" len (float (/ (- end start) 1000)))
    ))
