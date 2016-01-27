(ns ga-performance.core
  (:gen-class))

(def iterations 100000)
(def maxlength 32768)

;; crossover
(loop [len 16]
  (if (<= len maxlength)
    (do
      (let [arr1 (into [] (map (fn [_] (if (zero? (rand-int 2)) 1 0)) (range len)))
            arr2 (into [] (map (fn [_] (if (zero? (rand-int 2)) 1 0)) (range len)))]
        (let [start (. System (nanoTime))]
          (loop [k iterations]
            (if (> k 0)
              (do
                (let [point1 (rand-int len)
                      point2 (rand-int len)
                      mn (min point1 point2)
                      mx (max point1 point2)]
                  ;;(println arr1)
                  (let [newarr1 (into
                                 (into (subvec arr1 0 mn)
                                       (subvec arr2 mn mx))
                                 (subvec arr1 mx))
                        newarr2 (into
                                 (into (subvec arr2 0 mn)
                                       (subvec arr1 mn mx))
                                 (subvec arr2 mx))]))
                (recur (dec k)))))
          (println (str "clojure-persistentvector, " len ", " (float (/ (- (. System (nanoTime)) start) 1000000000))))
          ))
      (recur (bit-shift-left len 1)))
    true))
