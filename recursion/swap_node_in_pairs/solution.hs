swap_pair' :: [a] -> [a]  
swap_pair' [] = []  
swap_pair' [x] = [x]
swap_pair' (xa:xb:xs) = [xb, xa] ++ swap_pair'(xs)
