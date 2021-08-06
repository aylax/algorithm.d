impl Solution {
    pub fn get_row(rs: i32) -> Vec<i32> {
        pascal_m(rs)
    }
}

use std::collections::HashMap as M;
pub fn pascal_m(rs: i32) -> Vec<i32> {
    let mut mq: M<String, i32> = M::new();
    (0..=rs).map(|n| pascal(rs, n, &mut mq)).collect()
}

pub fn pascal(r: i32, c: i32, mq: &mut M<String, i32>) -> i32 {
    let key = format!("{}:{}", r, c);
    match mq.get(&key) {
        Some(v) => *v,
        None => {
            let result = match (r, c) {
                (_, 0) => 1,
                (rs, cs) if rs == cs => 1,
                _ => pascal(r - 1, c - 1, mq) + pascal(r - 1, c, mq),
            };
            mq.insert(key, result);
            result
        }
    }
}
