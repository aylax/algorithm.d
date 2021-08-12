merge' :: (Ord a) => [a] -> [a] -> [a]
merge' [] xs = xs
merge' xs [] = xs
merge' (a:as) (b:bs)
    | a < b  = a : merge' as (b:bs) 
    | otherwise = b : merge' (a:as) bs
