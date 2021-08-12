impl Solution {
    pub fn sort_array(mut xs: Vec<i32>) -> Vec<i32> {
        let h = xs.len() as usize;
        quick_sort(&mut xs, 0, h - 1);
        xs
    }
}

pub fn quick_sort(xs: &mut Vec<i32>, l: usize, h: usize) {
    if l < h {
        let k = plot(xs, l, h);
        if k > 1 {
            quick_sort(xs, l, k - 1);
        }
        quick_sort(xs, k + 1, h);
    }
}

pub fn plot(xs: &mut Vec<i32>, l: usize, h: usize) -> usize {
    let (mut i, mut j, e) = (l, h, xs[h]);
    while i != j {
        while i < j && xs[i] <= e {
            i = i + 1;
        }
        while i < j && xs[j] >= e {
            j = j - 1;
        }

        if i < j {
            xs.swap(i, j);
        }
    }
    xs.swap(i, h);
    i
}
