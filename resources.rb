# Resource Loader

module Tetris
  # Resource Loader for Tetris

  class ResourceLoader
    def self.fonts( window )
      {
        score:    Gosu::Font.new( window, 'Arial', 30 ),
        pause:    Gosu::Font.new( window, 'Serif', 48 )
      }
    end
  end
end
