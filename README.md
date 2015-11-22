# Benchmarks
### Well it turs out lookups on a binary tree are a whole lot faster when you do them a lot.

¯\\\_(ツ)\_/¯

```
include? 500 times
       user     system      total        real
array  0.010000   0.000000   0.010000 (  0.008144)
tree  0.010000   0.000000   0.010000 (  0.010028)


include? 5000 times
       user     system      total        real
array  0.480000   0.010000   0.490000 (  0.484483)
tree  0.050000   0.000000   0.050000 (  0.051959)


include? 50000 times
       user     system      total        real
array  7.260000   0.000000   7.260000 (  7.262872)
tree  0.620000   0.010000   0.630000 (  0.624963)


include? 500000 times
       user     system      total        real
array 77.960000   0.070000  78.030000 ( 78.083140)
tree  6.480000   0.090000   6.570000 (  6.576083)
```
