# SnakeFusion
This is a fork of [Code-Bullet/SnakeFusion][1] that I've created to start playing around with genetic algorithms.

### Current controls:

|  Key  |                       Action                        |
|:-----:|-----------------------------------------------------|
| Space | Toggle "Show all snakes"                            |
|   +   | Increase "Speed"                                    |
|   -   | Decrease "Speed"                                    |
|   d   | Increase "Mutation Rate" <sup>[1](#footnote1)</sup> |
|   h   | Decrease "Mutation Rate" <sup>[2](#footnote2)</sup> |
|   0   | Test Legend 0                                       |
|   1   | Test Legend 1                                       |
|   2   | Test Legend 2                                       |
|   3   | Test Legend 3                                       |
|   4   | Test Legend 4                                       |
|   f   | Fuse Legends                                        |
|   l   | Train Legends                                       |

### Notes
* The **Mutation Rate** is compared against a random float that is `>= 0` and `< 1`, for each "trait" in the child's weight matrices. If `rand < mutationRate` then that "trait" is mutated from the one the child originally received from its parents.
* The `population` variable in `SmartSnakesCombine` controls the number of snakes created in each generation.


### Footnotes
<a name="footnote1">1</a>: _Modified from original to increment by 0.01, with a max of 1_

<a name="footnote2">2</a>: _Modified from original to decrement by 0.01, with a min of 0_


[1]: https://github.com/Code-Bullet/SnakeFusion "Original Source"
