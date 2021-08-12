impl Solution {
    pub fn search_matrix(xs: Vec<Vec<i32>>, k: i32) -> bool {
        s2d(&xs[..], 0, k)
    }
}

fn s2d(xs: &[Vec<i32>], j: usize, k: i32) -> bool {
    if j >= xs.len() {
        return false;
    }
    bs(&xs[j][..], k) || s2d(xs, j + 1, k)
}

fn bs(xs: &[i32], k: i32) -> bool {
    if xs.is_empty() {
        return false;
    }
    let n = (xs.len() / 2) as usize;
    let (l, r) = (&xs[..n], &xs[n + 1..]);
    xs[n] == k || bs(l, k) || bs(r, k)
}
