-- Data.Vector.Unboxed allows for a specialised and more efficient representation
-- of a boolean vector.
import Data.Vector.Unboxed.Mutable as V
import Data.Vector.Unboxed as U
import Data.Traversable
import Control.Monad.Primitive
import Control.Monad
import Control.Monad.Random
import Control.Applicative
import System.Random
import Data.List
import Data.Time
import Auxiliary

iterations = 100000

-- Flips the given bit in a mutable vector, returns an action in m.
bitflip :: (PrimMonad m) => MVector (PrimState m) Bool -> Int -> m ()
bitflip v i = do
  x <- unsafeRead v i
  unsafeWrite v i (not x)

-- Complete benchmark for a given length
benchmark :: Int -> IO ()
benchmark len = do
  -- Random vector
  vector1 <- randomVector len
  vector2 <- randomVector len
  let seed = mkStdGen 3

  -- Timing
  start <- getCurrentTime

  -- Random crossings
  let cross = randomBoolList len seed :: [Bool]
  for [0..iterations-1] 
          (\i -> for [0..len-1]
                (\j ->
                     if (cross !! j) then
                         do 
                           x <- unsafeRead vector1 j
                           y <- unsafeRead vector2 j
                           unsafeWrite vector1 j y
                           unsafeWrite vector2 j x
                     else
                         do return ()
                )
          )

  stop <- getCurrentTime

  -- Printing
  putStrLn $ Data.List.concat ["Haskell-Mutable Vector, ", show len, ", ", show $ diffUTCTime stop start]


main :: IO ()
main = do
  Control.Monad.sequence $ Prelude.map benchmark ((2^) <$> [4..16])
  return ()
