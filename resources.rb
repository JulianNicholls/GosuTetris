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
        background:   Gosu::Image.new('media/background.png')
      }
    end

    def sounds
      {
        drop:   Gosu::Sample.new('media/Blip.wav'),
        smash:  Gosu::Sample.new('media/Explosion.wav')
      }
    end
  end
end
