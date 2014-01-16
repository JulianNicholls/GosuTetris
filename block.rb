# Block

require './constants'

module Tetris
  # Hold a (row, column) position insiode the Tetris Well

  class GridPoint < Struct.new( :row, :column )
    include Constants

    def offset( by_row, by_column )
      GridPoint.new( row + by_row, column + by_column )
    end

    def to_point
      Point.new( WELL_BORDER + column * BLOCK_SIDE, row * BLOCK_SIDE )
    end

    def move_by!( by_row, by_column )
      self.row    += by_row
      self.column += by_column
    end
  end

  # Draw a constituent block of a Tetris shape.

  class Block
    include Constants

    # Draw in the well, using a GridPoint

    def self.draw( window, gridpoint, colour )
      draw_absolute( window, gridpoint.to_point, colour )
    end

    # Draw at an absolute pixel position

    def self.draw_absolute( window, point, colour )
      size  = Size.new( BLOCK_SIDE, BLOCK_SIDE )
      window.draw_rectangle( point, size, 1, Gosu::Color::WHITE )

      size.inflate!( -2, -2 )
      window.draw_rectangle( point.offset( 1, 1 ), size, 1, colour )
    end
  end
end
