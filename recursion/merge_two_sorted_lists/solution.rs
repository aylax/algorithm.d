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
    pub fn merge_two_lists(
        l1: Option<Box<ListNode>>,
        l2: Option<Box<ListNode>>,
    ) -> Option<Box<ListNode>> {
        so(l1, l2)
    }
}

pub fn so(xas: Option<Box<ListNode>>, xbs: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    match (xas, xbs) {
        (xs, None) => xs,
        (None, xs) => xs,
        (Some(mut sa), Some(mut sb)) => {
            if sa.val < sb.val {
                sa.next = so(sa.next.take(), Some(sb));
                Some(sa)
            } else {
                sb.next = so(Some(sa), sb.next.take());
                Some(sb)
            }
        }
    }
}
