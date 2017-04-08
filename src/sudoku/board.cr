class Board

  getter :board

  def initialize(input : Array(Array(Int32 | Nil)))
    @board = input
  end

  def duplicate
    copy = duplicate_data
    Board.new(copy)
  end

  def get(row : Int32, column : Int32) : (Int32 | Nil)
    board[row][column]
  end

  def set(row : Int32, column : Int32, value : (Int32 | Nil))
    board[row][column] = value
    self
  end

  private def duplicate_data
    Array(Array(Int32 | Nil)).new.tap do |new_board|
      board.each do |row|
        new_row = Array(Int32 | Nil).new
        row.each do |number|
          new_row << number
        end
        new_board << new_row
      end
    end
  end
end
