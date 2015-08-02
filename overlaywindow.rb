require 'constants'
require 'resources'

module Tetris
  # Show an overlay window
  class OverlayWindow
    include Constants

    def initialize(surface)
      @fonts  = ResourceLoader.new(surface).fonts
      @window = surface
    end

    def say(text, font, col, row, colour)
      size = font.measure(text)

      col = (WIDTH - size.width) / 2   if col == :center
      row = (HEIGHT - size.height) / 2 if row == :center

      font.draw(text, col, row, 10, 1, 1, colour)
    end
  end
end
