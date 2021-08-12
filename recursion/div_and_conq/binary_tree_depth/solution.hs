data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

init' :: a -> Tree a
init' x = Node x Nil Nil

insert' :: (Ord a) => a -> Tree a -> Tree a
insert' x Nil =  init' x
insert' x (Node a left right)
    | x == a = Node x left right
    | x < a = Node a (insert' x left) right
    | x > a = Node a left (insert' x right)


depth' :: (Num a, Ord a) => Tree a -> a
depth' Nil = 0
depth' (Node _ left right) = 1 + (max (depth' left) (depth' right))

example_tree = foldr insert' Nil [8, 6, 3, 2, 1]
