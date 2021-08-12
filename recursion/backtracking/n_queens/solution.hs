-- n queue
queen :: Int -> [[Int]]
queen n = map reverse $ f n 
    where f 0 = [[]]
          f u = [x:xs | xs <- f (u - 1), x <- [1..n], safe x xs]
          safe x xs = not $ any (has x) $ zip [1..] xs
          has x (col, row) = x == row || abs (x - row) == col


-- length of queen 8
-- length $ queen 8
