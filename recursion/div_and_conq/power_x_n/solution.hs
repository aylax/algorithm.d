--              Num a
--              /   \  
--             /     \ 
--            /       \
--   (Fractional a)  (Integral a)
--       /   \           /   \  
--      /     \         /     \ 
--     /       \       /       \
--  Double   Float   Integer   Int
pow' :: (Fractional a, Integral b) => a -> b -> a
pow' x0 y0 | y0 < 0    = pow' (1.0 / x0) (0 - y0)
           | y0 == 0   = 1
           | otherwise = f x0 y0
    where -- f : x0 ^ y0 = x ^ y
          f x y | even y    = f (x * x) (y `quot` 2)
                | y == 1    = x
                | otherwise = g (x * x) (y `quot` 2) x         -- See Note [Half of y - 1]
          -- g : x0 ^ y0 = (x ^ y) * z
          g x y z | even y = g (x * x) (y `quot` 2) z
                  | y == 1 = x * z
                  | otherwise = g (x * x) (y `quot` 2) (x * z) -- See Note [Half of y - 1]
