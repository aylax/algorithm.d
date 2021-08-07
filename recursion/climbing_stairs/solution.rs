impl Solution {
    pub fn climb_stairs(n: i32) -> i32 {
        so(n + 1, 1, 2)
    }
}
pub fn so(n: i32, a: i32, b: i32) -> i32 {
    match n {
        1 | 2 => a,
        _ => so(n - 1, b, a + b),
    }
}
