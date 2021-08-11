data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

flat :: Tree a -> [a]
flat Nil = []
flat (Node a l r) = flat l ++ [a] ++ flat r


g :: (Ord a) => [a] -> Bool
g [] = True
g [x] = True
g (x:y:xs) = x < y && g (y:xs)



so :: (Ord a) => Tree a -> Bool
so root = g (flat root)


tree = Node 5 (Node 1 Nil Nil) (Node 4 (Node 3 Nil Nil) (Node 6 Nil Nil))

