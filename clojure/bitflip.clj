(ns ga-performance.core
  (:gen-class))

(def iterations 100000)
(def maxlength 32768)

;; bitflip
(loop [len 16]
  (if (<= len maxlength)
    (do
      (let [arr (into [] (map (fn [_] (if (zero? (rand-int 2)) 1 0)) (range len)))]
        (let [start (. System (nanoTime))]
          (loop [k iterations]
            (if (> k 0)
              (do
                (loop [a arr
                       c 0]
                  (if (>= c iterations)
                    true
                    (recur (update-in arr [(rand-int len)] #(bit-flip % 0))
                           (inc c))))
                (recur (dec k)))
              ))
          (println (str "clojure-persistentvector, " len ", " (float (/ (- (. System (nanoTime)) start) 1000000000))))))
      (recur (bit-shift-left len 1)))
    true))
