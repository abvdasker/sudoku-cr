class Solver

  class ImpossibleError < Exception; end

  getter :board

  def initialize(board : Array(Array(Int32 | Nil)))
    @board = Board.new(board)
  end

  def initialize(board : Board)
    @board = board
  end

  # necessary metadata:
  # - whether an entry was a guess or part of the input
  # - current position

  def solve
    new_board = board.duplicate

    direction = :forward
    current_row = 0
    current_column = 0
    while current_row < new_board.size && current_column < new_board.size
      if current_row == 0 && current_column == 0 && direction == :backward
        raise ImpossibleError.new("board cannot be solved")
      end
      if new_board.was_input?(current_row, current_column)
        if direction == :forward
          current_row, current_column = advance(new_board, current_row, current_column)
        elsif direction == :backward
          current_row, current_column = backtrack(new_board, current_row, current_column)
        end
        next
      end

      current_entry = new_board.get(current_row, current_column)
      if !current_entry.nil? && current_entry >= 9
        new_board.set(current_row, current_column, nil)
        direction = :backward
        current_row, current_column = backtrack(new_board, current_row, current_column)
        next
      end

      next_possible = find_next_possible(new_board, current_entry, current_row, current_column)
      if next_possible.nil?
        direction = :backward
        new_board.set(current_row, current_column, nil)
        current_row, current_column = backtrack(new_board, current_row, current_column)
        next
      end

      direction = :forward
      new_board.set(current_row, current_column, next_possible)
      current_row, current_column = advance(new_board, current_row, current_column)
    end

    new_board
  end

  private def find_next_possible(new_board, current_entry, current_row, current_column)
    current_entry ||= 0
    available = new_board.find_possible(current_row, current_column)
    available = available.select { |number| number > current_entry }
    if available.empty?
      nil
    else
      available[0]
    end
  end

  private def advance(new_board, current_row, current_column)
    current_column += 1
    if current_column == new_board.size
      current_row += 1
      current_column = 0
    end
    return [current_row, current_column]
  end

  private def backtrack(new_board, current_row, current_column)
    current_column -= 1
    if current_column < 0
      current_row -= 1
      current_column = new_board.size - 1
    end
    return [current_row, current_column]
  end
end
