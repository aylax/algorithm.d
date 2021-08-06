-- [0, 0] = 1
-- [i, j] = [i-1, j-1] + [i-1, j]

pascal :: Integral a => a -> a -> a
pascal 0 0 = 1
pascal n 0 = 1
pascal n r | n == r = 1
pascal n r = pascal (n - 1) (r - 1) + pascal (n - 1) r

binom :: Integral a => a -> [a]
binom n = map (pascal n) [0..n]

