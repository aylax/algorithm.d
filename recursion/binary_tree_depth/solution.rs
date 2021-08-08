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
    pub fn max_depth(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        so(&root)
    }
}

pub fn so(root: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
    match root {
        None => return 0,
        Some(rrt) => {
            let node = rrt.borrow();
            1 + std::cmp::max(so(&node.left), so(&node.right))
        }
    }
}
