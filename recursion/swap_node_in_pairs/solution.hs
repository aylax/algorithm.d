-- reverse list behaving the same as reverse string
reverse' :: [a] -> [a]  
reverse' [] = []  
reverse' (x:xs) = reverse' xs ++ [x] 
