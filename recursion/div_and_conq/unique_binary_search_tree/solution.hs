data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)


dp xs ys = [(x,y) | x <- xs, y <- ys]


f :: (Num a) => a -> [Tree a] -> [Tree a] -> [Tree a]
f k xs ys = map (\x -> Node k (fst x) (snd x)) (dp xs ys)


g :: (Num a, Enum a, Ord a) => a -> a -> [Tree a]
g a b
  | a > b = [Nil]
  | a == b = [Node a Nil Nil] 
  | otherwise = foldr (++) [] [f n (g a (n - 1)) (g (n + 1) b) | n <- [a..b]]


tick :: (Num a) => Tree a -> a
tick Nil = -1
tick (Node  a left right) = a


pick :: (Num a) => Tree a -> [Tree a]
pick Nil = []
pick (Node a Nil Nil) = []
pick (Node a n r) = [n, r]


echo :: (Num a) => [Tree a] -> [a]
echo [] = []
echo xs = (map tick xs) ++ (echo (foldr (++) [] [pick n | n <- xs]))


-- # GHCI
-- map echo (g 1 3)


ret = [[n] | n <- g 1 3]

