impl Solution {
    pub fn my_pow(x: f64, n: i32) -> f64 {
        so(x, n as i64)
    }
}

pub fn so(x: f64, n: i64) -> f64 {
    match (x, n) {
        (_, 0) | (1.0, _) => 1.0,
        (_, n) if n < 0 => so(1.0 / x, 0 - n),
        _ if n % 2 == 0 => square(so(x, n >> 1)),
        _ => x * square(so(x, n >> 1)),
    }
}

pub fn square(x: f64) -> f64 {
    x * x
}
