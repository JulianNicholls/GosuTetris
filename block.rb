# Block

require './constants'

module Tetris

  # Draw a constituent block of a Tetris shape.

  class Block
    include Constants

    def self.draw( window, row, column, colour )
      window.draw_rectangle( WELL_BORDER + column * BLOCK_SIDE, row * BLOCK_SIDE,
                             BLOCK_SIDE, BLOCK_SIDE, 1, Gosu::Color::WHITE )

      window.draw_rectangle( WELL_BORDER + column * BLOCK_SIDE + 1,
                             row * BLOCK_SIDE + 1,
                             BLOCK_SIDE - 2, BLOCK_SIDE - 2, 1, colour )
    end

    def self.draw_absolute( window, left, top, colour )
      window.draw_rectangle( left, top, BLOCK_SIDE, BLOCK_SIDE, 1,
                             Gosu::Color::WHITE )

      window.draw_rectangle( left + 1, top + 1, BLOCK_SIDE - 2, BLOCK_SIDE - 2, 1,
                             colour )
    end
  end
end
