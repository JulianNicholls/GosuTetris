require './constants'
require './gosu_enhanced'
require './overlaywindow.rb'

module Tetris
  # Show the window when the game is paused

  class GameOverWindow < OverlayWindow
    include Constants

    P_TOP     = 110
    P_LEFT    = 60
    P_WIDTH   = WIDTH  - (P_LEFT * 2)
    P_HEIGHT  = HEIGHT - (P_TOP * 2)

    def draw
      @window.draw_rectangle(
        Point.new( P_LEFT, P_TOP ), Size.new( P_WIDTH, P_HEIGHT ), 10, 0x20ffffff )

      say( 'GAME OVER', @fonts[:pause], :center, P_TOP + P_HEIGHT/ 4, BLUE )
      say( 'Press R to Restart', @fonts[:score],
           :center, P_TOP + P_HEIGHT * 3 / 5, BLUE )
      say( 'Press Escape to Exit', @fonts[:score],
           :center, P_TOP + P_HEIGHT * 4 / 5, BLUE )
    end
  end
end
