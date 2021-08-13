impl Solution {
    pub fn total_n_queens(n: i32) -> i32 {
        queen(n).len() as i32
    }
}

type Queen = Vec<Vec<i32>>;

fn queen(n: i32) -> Queen {
    de(n, n)
}

fn de(n: i32, u: i32) -> Queen {
    if u == 0 {
        return vec![vec![]];
    }
    de(n, u - 1)
        .iter()
        .map(|xs| {
            (1..=n)
                .filter(|&x| safe(x, &xs))
                .map(|x| {
                    let mut ret = vec![x];
                    ret.extend_from_slice(&xs);
                    ret
                })
                .collect::<Queen>()
        })
        .flatten()
        .collect::<Queen>()
}

fn safe(n: i32, xs: &[i32]) -> bool {
    !{ (1..).zip(xs).any(|(col, &row)| has(n, col, row)) }
}

fn has(n: i32, col: i32, row: i32) -> bool {
    n == row || (row - n).abs() == col
}
