data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

shift' :: (Num a) => a -> Tree a -> Tree a
shift' n Nil = Nil
shift' n (Node a left right) = Node (a + n) (shift' n left) (shift' n right)

cons' :: (Num a) => a -> Tree a -> Tree a -> Tree a 
cons' x left right = Node x left (shift' x right)

gen' n = [1..n]


   
 
