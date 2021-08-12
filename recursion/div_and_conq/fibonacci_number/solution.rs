impl Solution {
    pub fn fib(n: i32) -> i32 {
        fib_iter(n, 0, 1)
    }
}

pub fn fib_iter(n: i32, a: i32, b: i32) -> i32 {
    match n {
        0 => a,
        _ => fib_iter(n - 1, b, a + b),
    }
}
