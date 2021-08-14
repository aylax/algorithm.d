import Data.List
import Data.Char

data Cell = Fixed Int | Guess [Int] deriving (Show, Eq) 

-- define grid
type Row = [Cell]
type Grid = [Row]

chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = fxs : chunksOf n sxs
    where (fxs, sxs) = splitAt n xs


from :: [Char] -> Maybe Grid
from cs
   | length cs == 81 = traverse (traverse (?>)) . chunksOf 9 $ cs 
   | otherwise = Nothing
       where
           (?>) '.' = Just $ Guess [1..9]
           (?>) c
             | Data.Char.isDigit c && c > '0' = Just . Fixed . Data.Char.digitToInt $ c
             | otherwise = Nothing
grid_s = ".......1.4.........2...........5.4.7..8...3....1.9....3..4..2...5.1........8.6..."

showGrid :: Grid -> String
showGrid = unlines . map (unwords . map showCell)
  where
    showCell (Fixed x) = show x
    showCell _ = "."

showGridWithGuess :: Grid -> String
showGridWithGuess = unlines . map (unwords . map showCell)
  where
    showCell (Fixed x)     = show x ++ "          "
    showCell (Guess xs) =
      (++ "]")
      . Data.List.foldl' (\acc x -> acc ++ if x `elem` xs then show x else " ") "["
      $ [1..9]
