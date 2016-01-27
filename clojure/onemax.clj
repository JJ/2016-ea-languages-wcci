(ns ga-performance.core
  (:gen-class))

(def iterations 100000)
(def maxlength 32768)

;; onemax
(loop [len 16]
  (if (<= len maxlength)
    (do
      (let [arr (into [] (map (fn [_] (if (zero? (rand-int 2)) 1 0)) (range len)))]
        (let [start (. System (nanoTime))]
          (loop [k iterations]
            (if (> k 0)
              (do (for [i arr]
                    (count (filter #{1} arr)))
                  (recur (dec k)))))
          (println (str "clojure-persistentvector, " len ", " (float (/ (- (. System (nanoTime)) start) 1000000000))))))
      (recur (bit-shift-left len 1)))
    true))
