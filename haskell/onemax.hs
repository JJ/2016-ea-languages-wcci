import Data.Sequence hiding (take)
import Data.Time
import Data.Foldable hiding (concat)
import Control.Applicative
import Control.DeepSeq
import System.Random


iterations = 1000000

onemax :: Seq Bool -> Int
onemax v = Data.Foldable.foldl (\y -> (\x -> if x then y+1 else y)) 0 v

benchmark :: Int -> IO ()
benchmark n = do
  -- Random vector generation
  gen <- newStdGen
  let rbools = randoms gen :: [Bool]
  let vector = fromList $ take n rbools

  -- Timing
  start <- getCurrentTime

  -- Counting
  let count = onemax vector

  stop <- (count `deepseq` getCurrentTime)
  let diffTime = diffUTCTime stop start

  -- Printing
  putStrLn $ concat ["Haskell-Sequence, ", show n, ", ", show diffTime]

main :: IO ()
main = do
  sequence $ Prelude.map benchmark ((2^) <$> [4..16])
  return ()

