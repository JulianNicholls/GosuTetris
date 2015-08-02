require 'gosu_enhanced'

module Tetris
  # Constants for the Tetris Game
  module Constants
    include GosuEnhanced

    WELL_BORDER = 10
    COLUMNS     = 10
    ROWS        = 20

    PANEL_WIDTH = 210

    BLOCK_SIDE  = 28

    WIDTH       = WELL_BORDER + COLUMNS * BLOCK_SIDE + PANEL_WIDTH
    HEIGHT      = WELL_BORDER + ROWS * BLOCK_SIDE

    SCORE_TOP   = 20
    SCORE_LEFT  = WIDTH - (PANEL_WIDTH - 20)

    NEXT_POS    = Point.new(SCORE_LEFT, 100)

    # Colours

    CYAN        = Gosu::Color.new(0xff, 0x00, 0xff, 0xff)
    BLUE        = Gosu::Color.new(0xff, 0x00, 0x00, 0xff)
    ORANGE      = Gosu::Color.new(0xff, 0xff, 0xa5, 0x00)
    YELLOW      = Gosu::Color.new(0xff, 0xff, 0xff, 0x00)
    GREEN       = Gosu::Color.new(0xff, 0x80, 0xff, 0x00)
    PURPLE      = Gosu::Color.new(0xff, 0x80, 0x00, 0x80)
    RED         = Gosu::Color.new(0xff, 0xff, 0x00, 0x00)
  end
end
