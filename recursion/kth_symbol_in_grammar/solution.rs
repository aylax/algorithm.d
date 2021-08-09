/**                                                                                                                            
 * 0
 * 0 1
 * 0 1 1 0
 * 0 1 1 0 1 0 0 1
 * ---------------
 * n-2:  [ 0 ]
 * n-1: [ xas ]
 * n: [ xas | xbs ]
 * let len = list.size()
 * 如果 k 落在 xas (前半段), f(n, k) = f(n-1, k)
 * 如果 k 落在 xbs (后半段), f(n, k) = f(n-1, k - len / 2) ^ 1
 * tip: 后半段每一位都是前半段对应位取反
 */

impl Solution {
    pub fn kth_grammar(n: i32, k: i32) -> i32 {
        so(n, k)
    }
}


use std::cmp::Ordering;
pub fn so(n: i32, k: i32) -> i32 {
    if n == 1 {
        0
    } else {
        let lsp = (1 << (n - 1)) / 2;
        match k.cmp(&lsp) {
            Ordering::Greater => so(n - 1, k - lsp) ^ 1,
            _ => so(n - 1, k),
        }
    }
}
