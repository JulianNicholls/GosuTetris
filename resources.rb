# Resource Loader

module Tetris
  # Resource Loader for Tetris
  class ResourceLoader
    def initialize(window)
      @window = window
    end

    def fonts
      {
        score:    Gosu::Font.new(@window, 'Arial', 30),
        pause:    Gosu::Font.new(@window, 'Arial', 56)
      }
    end

    def images
      {
        background:   Gosu::Image.new(@window, 'media/background.png', true)
      }
    end

    def sounds
      {
        drop:   Gosu::Sample.new(@window, 'media/Blip.wav'),
        smash:  Gosu::Sample.new(@window, 'media/Explosion.wav')
      }
    end
  end
end
