--       0
--   0       1   
-- 0   1   1   0 

import Data.Bits
kth' :: (Integral a, Bits a, Ord a) => Int -> a -> a
kth' 1 k = 0
kth' n k
    | k > lsp = (kth' (n - 1) (k - lsp)) `xor` 1
    | otherwise = kth' (n - 1) k
  where lsp = (1 `shiftL` (n - 1)) `div` 2 
