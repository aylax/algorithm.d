matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]]


bs :: (Ord a) => a -> [a] -> Bool
bs n [] = False
bs n xs = n == m || bs n l || bs n r 
  where 
      j = (length xs) `div` 2
      m = xs !! j
      l = take j xs
      r = drop (j + 1) xs


s2d :: (Ord a) => a -> [[a]] -> Bool
s2d n [] = False
s2d n (x:xs) = bs n x || s2d n xs



