data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

shift' :: (Num a) => a -> Tree a -> Tree a
shift' n Nil = Nil
shift' n (Node a left right) = Node (a + n) (shift' n left) (shift' n right)

init' :: (Num a) => a -> Tree a -> Tree a -> Tree a 
init' x left right = Node x left (shift' x right)

gen_tree' n = [1..n]


   
 
