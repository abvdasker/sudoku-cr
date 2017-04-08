require "../spec_helper.cr"

describe Board do

  describe "#initialize" do
    it "raises an error" do
      input = BoardSpecHelper.build_input_rows_wrong

      expect_raises(Board::BoardDimensionsError, /incorrect number of rows/) do
        Board.new(input)
      end
    end
  end

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
    it "sets the value in the board" do
      input = BoardSpecHelper.build_input
      board = Board.new(input)

      board.set(2, 4, 8)

      board.board[2][4].should eq 8
    end
  end

  describe "#is_valid?" do
    it "return false" do
      input = BoardSpecHelper.build_input
      board = Board.new(input)

      board.is_valid?.should be_false
    end

    it "returns true" do
      valid_input = BoardSpecHelper.build_valid_input
      board = Board.new(valid_input)

      board.is_valid?.should be_true
    end
  end

end

class BoardSpecHelper

  def self.build_input_rows_wrong : Array(Array(Int32 | Nil))
    [
      [nil, 1]
    ]
  end
  
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

  def self.build_valid_input : Array(Array(Int32 | Nil))
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

end
