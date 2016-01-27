module Auxiliary where
import Data.Vector.Unboxed.Mutable as V
import Data.Vector.Unboxed as U
import Control.Monad.Primitive
import Control.Monad
import Control.Monad.Random
import Control.Applicative
import System.Random
import Data.List
import Data.Time

-- Sequences the reading of every element in a mutable vector.
printVector :: (Show a, Unbox a) => MVector (PrimState IO) a -> IO ()
printVector v = sequence [V.read v n | n <- [0..V.length v-1]] >>= print

-- Creates a random boolean list, given a generator
randomBoolList :: (Random a) => Int -> StdGen -> [a]
randomBoolList n = Data.List.take n . Data.List.unfoldr (Just . random)

-- Creates a random integer list, given a generator and a range
randomIntList :: Int -> (Int,Int) -> StdGen -> [Int]
randomIntList n (a,b) = Data.List.take n . Data.List.unfoldr (Just . (randomR (a,b)))

-- Creates a random mutable vector
randomVector :: Int -> IO (MVector (PrimState IO) Bool)
randomVector len = do
  let seed = mkStdGen 1
  let rs = (randomBoolList len seed) :: [Bool]
  vector <- V.replicate len False
  sequence $ Prelude.map (\n -> write vector n (rs!!n)) [0..len-1]
  return vector
