-- Data.Vector.Unboxed allows for a specialised and more efficient representation
-- of a boolean vector.
import Data.Vector.Unboxed.Mutable as V
import Data.Vector.Unboxed as U
import Control.Monad.Primitive
import Control.Monad
import Control.Monad.Random
import Control.Applicative
import System.Random
import Data.List
import Data.Time
import Auxiliary

-- Complete benchmark for a given length
benchmark :: Int -> IO ()
benchmark len = do
  -- Initialization
  vector <- V.replicate len False

  -- Timing
  start <- getCurrentTime

  -- Random vector
  let seed = mkStdGen 1
  let rs = (randomBoolList len seed) :: [Bool]
  sequence $ Prelude.map (\n -> write vector n (rs!!n)) [0..len-1]
             
  -- Counting
  sum <- fmap Data.List.sum (sequence (Data.List.map 
          (\i -> do
             x <- unsafeRead vector i
             if x then (return 1) else (return 0)
          ) [1..len]))
   
  stop <- getCurrentTime

  -- Printing
  putStrLn $ Data.List.concat ["Haskell-Mutable Vector, "
                              , show len, ", "
                              , show $ diffUTCTime stop start]

main :: IO ()
main = do
  sequence $ Prelude.map benchmark ((2^) <$> [4..16])
  return ()
