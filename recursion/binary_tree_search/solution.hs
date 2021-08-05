data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

init' :: a -> Tree a  
init' x = Node x Nil Nil

insert' :: (Ord a) => a -> Tree a -> Tree a
insert' x Nil =  init' x
insert' x (Node a left right)
    | x == a = Node x left right
    | x < a = Node a (insert' x left) right
    | x > a = Node a left (insert' x right)
 
search' :: (Ord a) => a -> Tree a -> Tree a
search' x Nil = Nil
search' x (Node a left right)
    | x == a = Node a left right
    | x < a = search' x left
    | x > a = search' x right



example_tree = foldr insert' Nil [8, 6, 3, 2, 1]
