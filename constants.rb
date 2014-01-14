# Constants

module Tetris
  # Constants for the Tetris Game

  module Constants
    WELL_BORDER = 10
    COLUMNS     = 10
    ROWS        = 20

    PANEL_WIDTH = 210

    BLOCK_SIDE  = 28

    WIDTH       = WELL_BORDER + COLUMNS * BLOCK_SIDE + PANEL_WIDTH
    HEIGHT      = WELL_BORDER + ROWS * BLOCK_SIDE

    SCORE_TOP   = 20
    SCORE_LEFT  = WIDTH - (PANEL_WIDTH - 20)

    NEXT_TOP    = 100
    NEXT_LEFT   = SCORE_LEFT
    NEXT_WIDTH  = 6 * BLOCK_SIDE
    NEXT_HEIGHT = 4 * BLOCK_SIDE

    # Colours

    BACKGROUND  = Gosu::Color.new( 0xff, 40, 40, 40 )
    GRID        = Gosu::Color.new( 0xff, 12, 12, 12 )
    GREEN       = Gosu::Color.new( 0xff, 0x50, 0xff, 0x50 )
    RED         = Gosu::Color.new( 0xff, 0xff, 0x50, 0x50 )
    BLUE        = Gosu::Color.new( 0xff, 0x50, 0x50, 0xff )
    PURPLE      = Gosu::Color.new( 0xff, 0xff, 0x50, 0xff )
    AQUA        = Gosu::Color.new( 0xff, 0x50, 0xff, 0xff )
    YELLOW      = Gosu::Color.new( 0xff, 0xff, 0xff, 0x50 )
  end
end
