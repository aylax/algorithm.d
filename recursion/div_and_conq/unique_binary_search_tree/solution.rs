// Definition for a binary tree node.
#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}
use std::cell::RefCell;
use std::rc::Rc;
type RRT = Rc<RefCell<TreeNode>>;

impl Solution {
    pub fn generate_trees(n: i32) -> Vec<Option<RRT>> {
        match n {
            0 => vec![],
            _ => so(n),
        }
    }
}

pub fn so(n: i32) -> Vec<Option<RRT>> {
    let mut xs = (0..=n + 1)
        .map(|x| vec![])
        .collect::<Vec<Vec<Option<RRT>>>>();
    xs[0].push(None);
    (1..=n).for_each(|range| {
        (1..=range).for_each(|idx| {
            make(&mut xs, idx, range);
        });
    });
    xs[n as usize].clone()
}

pub fn make(xs: &mut Vec<Vec<Option<RRT>>>, idx: i32, range: i32) {
    xs[(idx - 1) as usize]
        .iter_mut()
        .map(|e| e.clone())
        .collect::<Vec<Option<RRT>>>()
        .iter_mut()
        .for_each(|left| {
            let mut nodes = xs[(range - idx) as usize]
                .iter_mut()
                .map(|right| {
                    let mut node = TreeNode::new(idx);
                    node.left = left.clone();
                    node.right = shift(&right, idx);
                    Some(Rc::new(RefCell::new(node)))
                })
                .collect::<Vec<Option<RRT>>>();

            xs[range as usize].append(&mut nodes);
        })
}

pub fn shift(root: &Option<RRT>, offset: i32) -> Option<RRT> {
    match root {
        None => None,
        Some(rrt) => {
            let node = rrt.borrow();
            let mut ret = TreeNode::new(node.val + offset);
            ret.left = shift(&node.left, offset);
            ret.right = shift(&node.right, offset);
            Some(Rc::new(RefCell::new(ret)))
        }
    }
}
