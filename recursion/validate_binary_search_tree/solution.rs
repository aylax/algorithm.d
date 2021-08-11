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

type RRT = Rc<RefCell<TreeNode>>;

impl Solution {
    pub fn is_valid_bst(root: Option<RRT>) -> bool {
        so(&root)
    }
}

pub fn so(root: &Option<RRT>) -> bool {
    match root {
        None => true,
        Some(rrt) => {
            let node = rrt.borrow();
            let (v, l, r) = (node.val, node.left, node.right);
            cmp(gt, v, &l) && cmp(lt, v, &r) && so(&l) && so(&r)
        }
    }
}

fn gt(a: i32, b: i32) -> bool {
    a > b
}
fn lt(a: i32, b: i32) -> bool {
    a < b
}

pub fn cmp(op: fn(i32, i32) -> bool, val: i32, node: &Option<RRT>) -> bool {
    match &node {
        None => true,
        Some(rrts) => op(rrts.borrow().val, val),
    };
}
