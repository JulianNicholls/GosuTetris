# Resource Loader

module Tetris
  # Resource Loader for Tetris

  class ResourceLoader
    def self.fonts( window )
      {
        score:    Gosu::Font.new( window, 'Arial', 30 ),
        pause:    Gosu::Font.new( window, 'Arial', 56 )
      }
    end

    def self.images( window )
      {
        background:   Gosu::Image.new( window, 'media/background.png', true )
      }
    end
  end
end
