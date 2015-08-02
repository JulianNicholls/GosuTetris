require 'constants'

module Tetris
  # Hold a (row, column) position inside the Tetris Well
  class GridPoint
    include Constants

    attr_reader :row, :column

    def initialize(row, column)
      @row    = row
      @column = column
    end

    def move_by(by_row, by_column)
      dup.move_by!(by_row, by_column)
    end

    alias_method :offset, :move_by

    def move_by!(by_row, by_column)
      @row += by_row
      @column += by_column

      self
    end

    def valid?
      row.between?(0, ROWS - 1) && column.between?(0, COLUMNS - 1)
    end

    def to_point
      Point.new(WELL_BORDER + column * BLOCK_SIDE, row * BLOCK_SIDE)
    end
  end

  # Draw a constituent block of a Tetris shape.
  class Block
    include Constants

    def self.set_window(window)
      @window = window
    end

    # Draw in the well, using a GridPoint

    def self.draw(gridpoint, colour, outer = Gosu::Color::WHITE)
      draw_absolute(gridpoint.to_point, colour, outer)
    end

    # Draw at an absolute pixel position

    def self.draw_absolute(point, colour, outer = Gosu::Color::WHITE)
      size  = Size.new(BLOCK_SIDE, BLOCK_SIDE)
      @window.draw_rectangle(point, size, 1, outer) unless outer == 0

      size.deflate!(2, 2)
      @window.draw_rectangle(point.offset(1, 1), size, 1, colour)
    end
  end
end
