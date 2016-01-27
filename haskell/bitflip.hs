import Data.Sequence hiding (take)
import Data.Time
import Control.Applicative
import System.Random

iterations = 100000

-- The bitflip function
bitflip :: Seq Bool -> Int -> Seq Bool
bitflip v n = update n (not (index v n)) v


-- The benchmark
benchmark :: Int -> IO ()
benchmark n = do
  -- Random vector generation
  gen <- newStdGen
  let rbools = randoms gen :: [Bool]
  let vector = fromList $ Prelude.take n rbools

  -- Timing
  start <- getCurrentTime

  -- Random bitflips
  let rflips = randomRs (0,n-1) gen :: [Int]
  let changedvector = foldl bitflip vector rflips

  stop <- getCurrentTime
  let diffTime = diffUTCTime stop start

  -- Printing
  putStrLn $ concat ["Haskell-Sequence, ", show n, ", ", show diffTime]

main :: IO ()
main = do
  sequence $ map benchmark ((2^) <$> [4..16])
  return ()
