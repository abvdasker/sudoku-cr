require "../spec_helper"

describe Solver do

  describe "#solve" do
    it "is valid after being solved" do
      solvable = SolverSpecHelper.build_solvable_board
      board = Board.new(solvable)

      solved_board = Solver.new(board).solve

      solved_board.is_valid?.should be_true
    end

    it "finds the correct solution" do
      solvable = SolverSpecHelper.build_solvable_board
      board = Board.new(solvable)

      solved_board = Solver.new(board).solve

      solution = SolverSpecHelper.build_solved_board
      solution.each_index do |row_idx|
        solution[row_idx].each_index do |col_idx|
          expected = solution[row_idx][col_idx]
          actual = solved_board.get(row_idx, col_idx)
          actual.should eq expected
        end
      end
    end
  end

end

class SolverSpecHelper
  def self.build_solved_board : Array(Array(Int32 | Nil))
    [
      [5, 3, 4, 6, 7, 8, 9, 1, 2],
      [6, 7, 2, 1, 9, 5, 3, 4, 8],
      [1, 9, 8, 3, 4, 2, 5, 6, 7],
      [8, 5, 9, 7, 6, 1, 4, 2, 3],
      [4, 2, 6, 8, 5, 3, 7, 9, 1],
      [7, 1, 3, 9, 2, 4, 8, 5, 6],
      [9, 6, 1, 5, 3, 7, 2, 8, 4],
      [2, 8, 7, 4, 1, 9, 6, 3, 5],
      [3, 4, 5, 2, 8, 6, 1, 7, 9]
    ].map do |row|
      row.map do |entry|
        entry.as(Int32 | Nil)
      end
    end
  end

  def self.build_solvable_board
    [
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
  end
end
