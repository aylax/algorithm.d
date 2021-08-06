impl Solution {
    pub fn fib(n: i32) -> i32 {
        fib_iter(n, 0, 1)
    }
}

pub fn fib_iter(step: i32, prev: i32, next: i32) -> i32 {
    match step {
        0 => prev,
        _ => fib_iter(step - 1, next, prev + next),
    }
}
