# Constants

module Tetris
  # Constants for the Tetris Game

  module Constants
    WIDTH   = 540
    HEIGHT  = 570

    WELL_BORDER = 10
    COLUMNS     = 10
    ROWS        = 20

    PANEL_WIDTH = 250

    BLOCK_SIDE  = 28

    SCORE_TOP   = 20
    SCORE_LEFT  = WIDTH - (PANEL_WIDTH - 20)

    NEXT_TOP    = 100
    NEXT_LEFT   = SCORE_LEFT
    NEXT_WIDTH  = 6 * BLOCK_SIDE
    NEXT_HEIGHT = 4 * BLOCK_SIDE

    # Colours

    BACKGROUND  = Gosu::Color.new( 0xff, 40, 40, 40 )
    GRID        = Gosu::Color.new( 0xff, 12, 12, 12 )
    GREEN       = Gosu::Color.new( 0xff, 0x60, 0xff, 0x60 )
    RED         = Gosu::Color.new( 0xff, 0xff, 0x60, 0x60 )
    BLUE        = Gosu::Color.new( 0xff, 0x60, 0x60, 0xff )
    PURPLE      = Gosu::Color.new( 0xff, 0xff, 0x60, 0xff )
  end
end
