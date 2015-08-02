require 'constants'
require 'overlaywindow.rb'

module Tetris
  # Show the window when the game is over
  class GameOverWindow < OverlayWindow
    include Constants

    P_ORIGIN  = Point.new(60, 110)
    P_SIZE    = Size.new(WIDTH - (P_ORIGIN.x * 2), HEIGHT - (P_ORIGIN.y * 2))

    def draw
      @window.draw_rectangle(P_ORIGIN, P_SIZE, 10, 0xc0ffffff)

      draw_header
      draw_keys
    end

    def draw_header
      say('GAME OVER', :pause, :center, P_ORIGIN.y + P_SIZE.height / 4, BLUE)
    end

    def draw_keys
      base_row  = P_ORIGIN.y
      height    = P_SIZE.height

      say('Press R to Restart', :score,
          :center, base_row + height * 3 / 5, BLUE)

      say('Press Escape to Exit', :score,
          :center, base_row + height * 4 / 5, BLUE)
    end
  end
end
