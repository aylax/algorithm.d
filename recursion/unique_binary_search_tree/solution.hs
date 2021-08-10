data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

cart_prod xs ys = [(x,y) | x <- xs, y <- ys]

make :: (Num a) => a -> [Tree a] -> [Tree a] -> [Tree a]
make val xs ys = map (\x -> Node val (fst x) (snd x)) (cart_prod xs ys)

echo :: (Num a) => Tree a -> [a]
echo Nil = [-1]
echo (Node a Nil Nil) = [a]
echo (Node a left right) = [a] ++ (echo left) ++ (echo right)


loop :: (Num a, Enum a, Ord a) => a -> a -> [Tree a]
loop start end 
  | start > end = [Nil]
  | start == end = [Node start Nil Nil] 
  | otherwise = foldr (++) [] [make n (loop start (n - 1)) (loop (n + 1) end) | n <- [start..end]]


-- # GHCI
-- map echo (loop 1 3)
