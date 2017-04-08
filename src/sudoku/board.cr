class Board

  class BoardDimensionsError < Exception; end

  getter :board

  @original_input : Array(Array(Int32 | Nil))

  def initialize(input : Array(Array(Int32 | Nil)))
    @board = input
    validate_board_dimensions
    @original_input = duplicate_data
  end

  def solve
    Solver.new(self).solve
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
    available = check_row(row, column, available)
    available = check_column(row, column, available)
    available
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

  def inspect
    String.build do |whole_string|
      board.each_index do |row_idx|
        if row_idx % 3 == 0
          whole_string  << "-" * (9 + 3)
          whole_string << "\n"
        end

        row = board[row_idx]
        row_elems = String.build do |row_elems|
          row.each_index do |col_idx|
            elem = row[col_idx]
            if col_idx > 0 && col_idx % 3 == 0
              row_elems << "|"
            end
            if elem.nil?
              row_elems << " "
            else
              row_elems << elem.to_s
            end
          end
        end
        whole_string << row_elems
        whole_string << "\n"
      end
    end
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

  private def check_row(row : Int32, column : Int32, available : Array(Int32)) : Array(Int32)
    board[row].each_index do |column_idx|
      next if column_idx == column
      available -= [board[row][column_idx]]
    end
    available
  end

  private def check_column(row : Int32, column : Int32, available : Array(Int32)) : Array(Int32)
    board.each_index do |row_idx|
      next if row_idx == row
      column_entry = board[row_idx][column]
      available = available - [column_entry]
    end

    available
  end

  private def check_box(row : Int32, column : Int32, available : Array(Int32)) : Array(Int32)
    row_center, col_center = get_box_center(row, column)

    row_above = row_center - 1
    row_below = row_center + 1

    column_left = col_center - 1
    column_right = col_center + 1

    upper_left = get(row_above, column_left)
    upper_top = get(row_above, col_center)
    upper_right = get(row_above, column_right)

    left = get(row_center, column_left)
    right = get(row_center, column_right)

    bottom_left = get(row_below, column_left)
    bottom_below = get(row_below, col_center)
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
    other_entries.delete(board[row][column])
    result = available - other_entries

    result
  end

  private def validate_board_dimensions
    if board.size != 9
      raise BoardDimensionsError.new("incorrect number of rows #{board.size}")
    end

    board.each_index do |row_idx|
      row = board[row_idx]
      if row.size != 9
        raise BoardDimensionsError.new("row #{row_idx} has incorrect number of columns #{row.size}")
      end
    end
  end

  private def get_box_center(row : Int32, column : Int32)
    box_row_center = ((row / 3) * 3) + 1
    box_col_center = ((column / 3) * 3) + 1
    return [box_row_center, box_col_center]
  end

  private getter :original_input
end
