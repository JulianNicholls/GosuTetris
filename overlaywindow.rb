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

    def say(text, font, x, y, colour)
      size = font.measure(text) if x == :center || y == :center

      x = (WIDTH - size.width) / 2   if x == :center
      y = (HEIGHT - size.height) / 2 if y == :center

      font.draw(text, x, y, 10, 1, 1, colour)
    end
  end
end
