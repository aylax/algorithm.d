Given an integer n, return all the structurally unique BST's (binary search trees), which has exactly n nodes of unique values from 1 to n. Return the answer in any order.

 

Example 1:


Input: n = 3
Output: [[1,null,2,null,3],[1,null,3,2],[2,1,3],[3,1,null,null,2],[3,2,null,1]]
Example 2:

Input: n = 1
Output: [[1]]
 

Constraints:

1 <= n <= 8


### 递归实现:

```
Make (Num a) => [a] -> [Tree a]
Make(1..k..n) = 
Ret = []
Make(1..k-1).forEach(left => {
    Make(k..n).forEach(right => {
        Tree root = Tree::new(k, left, right);
        Ret.add(root);
    });
});

```
    


### 动态规划:

观察得知: Set(1,2,3) 组成的 UniqueTree 与 Set(2,3,4) 组成的UniqueTree在结构上是相同的,
唯一的区别只是对应位置上的节点数值不同.
结论: 若N1,N2为连续数组, 且N1 shiftR K == N2, 
则Tree(N1) 与 Tree(N2) 同构, TreeNode(N2).V = TreeNode(N1).V + K

