cb :: (Integral a) => a -> a
cb 1 = 1
cb 2 = 2
cb n = cb (n - 1) + cb (n - 2)
