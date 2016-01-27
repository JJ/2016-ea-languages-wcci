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

iterations = 100000

-- Flips the given bit in a mutable vector, returns an action in m.
bitflip :: (PrimMonad m) => MVector (PrimState m) Bool -> Int -> m ()
bitflip v i = do
  x <- unsafeRead v i
  unsafeWrite v i (not x)

-- Complete benchmark for a given length
benchmark :: Int -> IO ()
benchmark len = do
  vector <- randomVector len
  let seed2 = mkStdGen 2

  -- Timing
  start <- getCurrentTime

  -- Random bitflips
  let res = (randomIntList iterations (0,len-1) seed2) :: [Int]
  sequence $ Prelude.map (\pos -> bitflip vector pos) res

  stop <- getCurrentTime

  -- Printing
  putStrLn $ Data.List.concat ["Haskell-Mutable Vector, ", show len, ", ", show $ diffUTCTime stop start]


main :: IO ()
main = do
  sequence $ Prelude.map benchmark ((2^) <$> [4..16])
  return ()
