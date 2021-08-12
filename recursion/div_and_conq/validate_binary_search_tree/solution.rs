// Definition for a binary tree node.
// #[derive(Debug, PartialEq, Eq)]
// pub struct TreeNode {
//   pub val: i32,
//   pub left: Option<Rc<RefCell<TreeNode>>>,
//   pub right: Option<Rc<RefCell<TreeNode>>>,
// }
//
// impl TreeNode {
//   #[inline]
//   pub fn new(val: i32) -> Self {
//     TreeNode {
//       val,
//       left: None,
//       right: None
//     }
//   }
// }
use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn is_valid_bst(root: Option<RRT>) -> bool {
        so(&root, std::i64::MIN, std::i64::MAX)
    }
}

pub fn so(root: &Option<RRT>, min: i64, max: i64) -> bool {
    match root {
        None => true,
        Some(rrt) => {
            let p = rrt.borrow();
            let (n, l, r) = (p.val as i64, &p.left, &p.right);
            min < n && n < max && so(l, min, n) && so(r, n, max)
        }
    }
}
