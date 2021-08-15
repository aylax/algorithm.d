import Data.List
import Data.Char
import Data.Function (on)
import Control.Monad
import Control.Applicative


-- split list in to several lists of same len
-- sharding 2 [1 2 3 4] = [[1 2] [3 4]]
sharding :: Int -> [a] -> [[a]]
sharding _ [] = []
sharding n xs = fs : sharding n ys
    where (fs, ys) = splitAt n xs


-- define grid
data Cell = Fixed Int | Guess [Int] deriving (Show, Eq) 
type Grid = [[Cell]]


-- take out illegal guess on list
pruneM :: [Cell] -> Maybe [Cell]
pruneM xs = traverse prune xs
    where
        diff = (Data.List.\\)
        fs = [x | Fixed x <- xs]
        prune :: Cell -> Maybe Cell
        prune (Fixed x) = Just $ Fixed x
        prune (Guess gs) = case gs `diff` fs of 
                            [] -> Nothing
                            [y] -> Just $ Fixed y
                            ys -> Just $ Guess ys 


-- fold subgrid to rows
subGridsToRows :: Grid -> Grid
subGridsToRows =
  concatMap (\rows -> let [r1, r2, r3] = map (sharding 3) rows
                      in zipWith3 (\a b c -> a ++ b ++ c) r1 r2 r3)
  . sharding 3


-- takeout invalid value
pruneGrid' :: Grid -> Maybe Grid
pruneGrid' grid =
  traverse pruneM grid
  >>= fmap Data.List.transpose . traverse pruneM . Data.List.transpose
  >>= fmap subGridsToRows . traverse pruneM . subGridsToRows


pruneGrid :: Grid -> Maybe Grid
pruneGrid = fixM pruneGrid'
  where
    fixM f x = f x >>= \x' -> if x' == x then return x else fixM f x'


-- get next grids
nextGrids :: Grid -> (Grid, Grid)
nextGrids grid =
  let (i, first@(Fixed _), rest) =
        fixCell
        . Data.List.minimumBy (compare `Data.Function.on` (possibilityCount . snd))
        . filter (isPossible . snd)
        . zip [0..]
        . concat
        $ grid
  in (replace2D i first grid, replace2D i rest grid)
  where
    isPossible (Guess _) = True
    isPossible _            = False

    possibilityCount (Guess xs) = length xs
    possibilityCount (Fixed _)     = 1

    fixCell (i, Guess [x, y]) = (i, Fixed x, Fixed y)
    fixCell (i, Guess (x:xs)) = (i, Fixed x, Guess xs)
    fixCell _                    = error "Impossible case"

    replace2D :: Int -> a -> [[a]] -> [[a]]
    replace2D i v =
      let (x, y) = (i `quot` 9, i `mod` 9) in replace x (replace y (const v))
    replace p f xs = [if i == p then f x else x | (x, i) <- zip xs [0..]]


-- has finish
isGridFilled :: Grid -> Bool
isGridFilled grid = null [ () | Guess _ <- concat grid ]


-- is this a valid grid
isGridInvalid :: Grid -> Bool
isGridInvalid grid =
  any isInvalidRow grid
  || any isInvalidRow (Data.List.transpose grid)
  || any isInvalidRow (subGridsToRows grid)
  where
    isInvalidRow row =
      let fixeds         = [x | Fixed x <- row]
          emptyPossibles = [x | Guess x <- row, null x]
      in hasDups fixeds || not (null emptyPossibles)

    hasDups l = hasDups' l []

    hasDups' [] _ = False
    hasDups' (y:ys) xs
      | y `elem` xs = True
      | otherwise   = hasDups' ys (y:xs)


-- read from [char]
buildGrid :: [Char] -> Maybe Grid
buildGrid xs
   | length xs == 81 = traverse (traverse (?>)) . sharding 9 $ xs 
   | otherwise = Nothing
       where
           valid x = Data.Char.isDigit x
           parse = Data.Char.digitToInt
           pack = Just . Fixed . parse
           (?>) '.' = Just $ Guess [1..9]
           (?>) x
             | valid x = pack x
             | otherwise = Nothing


-- solve soduku
solve :: Grid -> Maybe Grid
solve grid = pruneGrid grid >>= solve'
  where
    solve' g
      | isGridInvalid g = Nothing
      | isGridFilled g  = Just g
      | otherwise       =
          let (grid1, grid2) = nextGrids g
          in solve grid1 <|> solve grid2


-- show grid as str
showGrid :: Grid -> [Char]
showGrid = unlines . map (unwords . map showCell)
  where
    showCell (Fixed x) = show x
    showCell _ = "."


-- show grid as str with guess
showGrid' :: Grid -> [Char]
showGrid' = unlines . map (unwords . map showCell)
  where
    showCell (Fixed x)  = show x ++ "          "
    showCell (Guess xs) = (++ "]") . Data.List.foldl' cout "[" $ [1..9]
          where cout = \acc x -> acc ++ if x `elem` xs then show x else " "



main :: IO ()
main = do
  inputs <- lines <$> getContents
  Control.Monad.forM_ inputs $ \input ->
    case buildGrid input of
      Nothing   -> putStrLn "Invalid input"
      Just grid -> case solve grid of
        Nothing    -> putStrLn "No solution found"
        Just grid' -> putStrLn $ showGrid grid'


-- GHCI
-- Just grid = buildFrom text
-- putStrLn $ showGrid grid
-- main
-- .......1.4.........2...........5.4.7..8...3....1.9....3..4..2...5.1.......    .8.6...
