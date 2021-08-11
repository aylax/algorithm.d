-- quick sort
so :: (Ord a) => [a] -> [a]
so [] = []
so (x:xs) = (so ls) ++ [x] ++ (so gs) 
    where
        ls = [n | n <- xs, n < x]
        gs = [n | n <- xs, n >= x]
