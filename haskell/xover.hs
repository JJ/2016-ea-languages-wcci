import Prelude hiding (splitAt)
import Data.Sequence hiding (take,zip)
import Data.Time
import Control.Applicative
import System.Random

iterations = 100000

xover :: (Seq Bool, Seq Bool) -> (Int, Int) -> (Seq Bool, Seq Bool)
xover (v,w) (a,b) = ((x >< p >< z),(o >< y >< q))
    where
      (x,yz) = splitAt a v
      (y,z)  = splitAt b yz
      (o,pq) = splitAt a w
      (p,q)  = splitAt b pq


benchmark :: Int -> IO ()
benchmark n = do
    -- Random vector generation
    gena <- newStdGen
    genb <- newStdGen
    let rbools1 = randoms gena :: [Bool]
    let rbools2 = randoms genb :: [Bool]
    let vector1 = fromList $ take n rbools1
    let vector2 = fromList $ take n rbools2

    -- Timing
    start <- getCurrentTime

    -- Random crossings
    gen1 <- newStdGen
    gen2 <- newStdGen
    let unordcross = uncurry zip $ (randoms gen1 :: [Int], randoms gen2 :: [Int])
    let cross = map (\(a,b) -> (max a b, min a b)) unordcross
    let (cvector1,cvector2) = foldl xover (vector1,vector2) cross

    stop <- getCurrentTime
    let diffTime = diffUTCTime stop start

    -- Printing
    putStrLn $ concat ["Haskell-Sequence, ", show n, ", ", show diffTime]

main :: IO ()
main = do
  sequence $ map benchmark ((2^) <$> [4..16])
  return ()
