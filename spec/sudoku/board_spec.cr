require "../spec_helper.cr"

describe Board do
  describe "#duplicate" do
    it "creates a new copy of the input board" do
      input = BoardSpecHelper.build_input
      original = Board.new(input)

      copy = original.duplicate
      copy.set(1, 1, 9)

      copy.get(1, 1).should eq 9
      original.get(1, 1).should eq nil
    end

    it "copies the contents of the original board" do
      input = BoardSpecHelper.build_input
      original = Board.new(input)

      copy = original.duplicate

      matches = true
      copy.board.each_index do |row_idx|
        copy.board[row_idx].each_index do |col_idx|
          copy_entry = copy.board[row_idx][col_idx]
          original_entry = original.board[row_idx][col_idx]
          matches &&= (copy_entry == original_entry)
        end
      end
      matches.should be_true
    end
  end

  describe "#get" do
    it "returns the correct value at the position" do
      input = BoardSpecHelper.build_input
      board = Board.new(input)

      board.get(2, 4).should eq 4
    end
  end

  describe "#set" do
    input = BoardSpecHelper.build_input
    board = Board.new(input)

    board.set(2, 4, 8)
    
    board.board[2][4].should eq 8
  end
end

class BoardSpecHelper
  def self.build_input : Array(Array(Int32 | Nil))
    [
      [1, 2, nil, nil, nil, nil, 9, nil, 3],
      [nil, nil, 4, nil, nil, nil, 1, nil, nil],
      [nil, 3, nil, nil, 4, nil, nil, nil, 2],
      [nil, nil, nil, nil, nil, 3, nil, nil, nil],
      [nil, nil, 1, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, 6, nil, nil, nil, nil, nil],
      [3, nil, 2, nil, nil, nil, nil, nil, 9],
      [nil, nil, nil, nil, 5, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, 7, nil, nil],
    ]
  end
end
