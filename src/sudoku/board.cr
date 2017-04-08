class Board

  getter :board

  @original_input : Array(Array(Int32 | Nil))

  def initialize(input : Array(Array(Int32 | Nil)))
    @board = input
    @original_input = duplicate_data
  end

  def size
    board.size
  end

  def duplicate
    copy = duplicate_data
    Board.new(copy)
  end

  def is_valid?
    board.each_index do |row|
      board[row].each_index do |column|
        if get(row, column).nil? || !is_entry_valid?(row, column)
          return false
        end
      end
    end

    true
  end

  def find_possible(row : Int32, column : Int32) : Array(Int32)
    available = (1..9).to_a
    available = check_box(row, column, available)
    available = check_row(row, available)
    available = check_column(column, available)
  end

  def is_set?(row : Int32, column : Int32)
    !board[row][column].nil?
  end

  def was_input?(row : Int32, column : Int32)
    !original_input[row][column].nil?
  end

  def get(row : Int32, column : Int32) : (Int32 | Nil)
    board[row][column]
  end

  def set(row : Int32, column : Int32, value : (Int32 | Nil))
    board[row][column] = value
    self
  end

  private def is_entry_valid?(row : Int32, column : Int32)
    entry = get(row, column)
    possible = find_possible(row, column)
    possible.includes?(entry)
  end

  private def duplicate_data : Array(Array(Int32 | Nil))
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

  private def check_row(row : Int32, available : Array(Int32)) : Array(Int32)
    available - board[row]
  end

  private def check_column(column : Int32, available : Array(Int32)) : Array(Int32)
    board.each do |row|
      column_entry = row[column]
      available = available - [column_entry]
    end

    available
  end

  private def check_box(row : Int32, column : Int32, available : Array(Int32)) : Array(Int32)
    row_above = Math.max(0, row - 1)
    row_below = Math.min(row + 1, size - 1)

    column_left = Math.max(0, column - 1)
    column_right = Math.min(column + 1, size - 1)

    upper_left = get(row_above, column_left)
    upper_top = get(row_above, column)
    upper_right = get(row_above, column_right)

    left = get(row, column_left)
    right = get(row, column_right)

    bottom_left = get(row_below, column_left)
    bottom_below = get(row_below, column)
    bottom_right = get(row_below, column_right)

    other_entries = [
      upper_left,
      upper_top,
      upper_right,
      left,
      right,
      bottom_left,
      bottom_below,
      bottom_right
    ]
    available - other_entries
  end

  private getter :original_input
end
