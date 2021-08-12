impl Solution {
    pub fn reverse_string(xs: &mut Vec<char>) {
        helper_v2(xs, 0, xs.len() as usize - 1)
    }
}

// Solution 1
fn helper_v1(xs: &mut Vec<char>, pa: usize, pb: usize) {
    if pa < pb {
        swap(xs, pa, pb);
        helper_v1(xs, pa + 1, pb - 1)
    }
}

// Solution 2
fn helper_v2(xs: &mut Vec<char>, a: usize, b: usize) {
    let (mut pa, mut pb) = (a, b);
    while pa < pb {
        swap(xs, pa, pb);
        pa = pa + 1;
        pb = pb - 1;
    }
}

fn swap(xs: &mut Vec<char>, pa: usize, pb: usize) {
    let tmp = xs[pa];
    xs[pa] = xs[pb];
    xs[pb] = tmp;
}
