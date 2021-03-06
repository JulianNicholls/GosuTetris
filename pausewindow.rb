require 'constants'
require 'overlaywindow.rb'

module Tetris
  # Show the window when the game is paused
  class PauseWindow < OverlayWindow
    include Constants

    P_ORIGIN  = Point.new(60, 110)
    P_SIZE    = Size.new(WIDTH - (P_ORIGIN.x * 2), HEIGHT - (P_ORIGIN.y * 2))

    def draw
      @window.draw_rectangle(P_ORIGIN, P_SIZE, 10, 0xc0ffffff)

      row_base  = P_ORIGIN.y
      size      = P_SIZE.height

      say('PAUSED', :pause, :center, row_base + size / 4, BLUE)
      say('Press P to Continue', :score,
          :center, row_base + size * 3 / 5, BLUE)
    end
  end
end
