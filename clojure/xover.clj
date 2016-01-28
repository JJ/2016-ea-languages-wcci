(ns ga-performance.core
  (:gen-class))

(def iterations 100000)
(def maxlength 32768)

;; crossover
(loop [len 16]
  (if (<= len maxlength)
    (do
      (let [arr1 (transient (into [] (map (fn [_] (if (zero? (rand-int 2)) 1 0)) (range len))))
            arr2 (transient (into [] (map (fn [_] (if (zero? (rand-int 2)) 1 0)) (range len))))]
        (let [start (. System (nanoTime))]
          (dotimes [k iterations]
            (let [point1 (rand-int len)
                  point2 (rand-int len)
                  mn (min point1 point2)
                  mx (max point1 point2)]
              (dotimes [j (- mx mn)]
                (let [tmp (get arr1 (+ j mn))]
                  (assoc! arr1 (+ j mn) (get arr2 (+ j mn)))
                  (assoc! arr2 (+ j mn) tmp)))
              ))
          (println (str "clojure-transientvector, " len ", " (float (/ (- (. System (nanoTime)) start) 1000000000))))
          ))
      (recur (bit-shift-left len 1)))
    true))

(dotimes )
