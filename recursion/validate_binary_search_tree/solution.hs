data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)


val :: (Ord a) => Tree a -> a
val (Node a left right) = a


car :: (Ord a) => Tree a -> Tree a
car Nil = Nil
car (Node a left right) = left


cdr :: (Ord a) => Tree a -> Tree a
cdr Nil = Nil
cdr (Node a left right) = right


sk :: (Ord a) => (a -> a -> Bool) -> a -> Tree a -> Bool
sk f n Nil = True
sk f n (Node a left right) = f a n


check :: (Ord a) => Tree a -> Bool
check Nil = True
check root = sk (<) n l && sk (>) n r && check l && check r
    where 
        n = (val root)
        l = (car root)
        r = (cdr root)


