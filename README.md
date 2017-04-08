# sudoku

A simple sudoku solver in Crystal. Implements brute-force with backtracking.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  sudoku:
    github: [your-github-name]/sudoku
```

## Usage

```crystal
require "sudoku"

include Sudoku

sudoku = [
  [5, 3, nil, nil, 7, nil, nil, nil, nil],
  [6, nil, nil, 1, 9, 5, nil, nil, nil],
  [nil, 9, 8, nil, nil, nil, nil, 6, nil],
  [8, nil, nil, nil, 6, nil, nil, nil, 3],
  [4, nil, nil, 8, nil, 3, nil, nil, 1],
  [7, nil, nil, nil, 2, nil, nil, nil, 6],
  [nil, 6, nil, nil, nil, nil, 2, 8, nil],
  [nil, nil, nil, 4, 1, 9, nil, nil, 5],
  [nil, nil, nil, nil, 8, nil, nil, 7, 9]
]

solved_sudoku = Board.new(sudoku).solve

puts solved_sudoku.inspect # prints:
#
# 534|678|912
# 672|195|348
# 198|342|567
# ------------
# 859|761|423
# 426|853|791
# 713|924|856
# ------------
# 961|537|284
# 287|419|635
# 345|286|179

```
