// Definition for singly-linked list.
// #[derive(PartialEq, Eq, Clone, Debug)]
// pub struct ListNode {
//   pub val: i32,
//   pub next: Option<Box<ListNode>>
// }
// 
// impl ListNode {
//   #[inline]
//   fn new(val: i32) -> Self {
//     ListNode {
//       next: None,
//       val
//     }
//   }
// }
impl Solution {
    pub fn swap_pairs(head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        match head {
            None => { return None; },
            Some(mut cur) => match cur.next {
                None => {return Some(cur); },
                Some(mut next) => {
                    cur.next = Solution::swap_pairs(next.next);
                    next.next = Some(cur);
                    Some(next)
                }
            }
        }
    }
}
