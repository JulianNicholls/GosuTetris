require './constants'
require './gosu_enhanced'
require './overlaywindow.rb'

module Tetris
  # Show the window when the game is paused

  class PauseWindow < OverlayWindow
    include Constants

    P_TOP     = 110
    P_LEFT    = 60
    P_WIDTH   = WIDTH  - (P_LEFT * 2)
    P_HEIGHT  = HEIGHT - (P_TOP * 2)

    def draw
      @window.draw_rectangle(
        Point.new( P_LEFT, P_TOP ), Size.new( P_WIDTH, P_HEIGHT ), 10, 0x20ffffff )

      say( 'PAUSED', @fonts[:pause], :center, P_TOP + P_HEIGHT / 4, BLUE )
      say( 'Press P to Continue', @fonts[:score],
           :center, P_TOP + P_HEIGHT * 3 / 5, BLUE )
    end
  end
end
