# Resource Loader

module Tetris
  # Resource Loader for Tetris

  class ResourceLoader
    def self.fonts( window )
      {
        score:    Gosu::Font.new( window, 'Serif', 20 )
      }
    end
  end
end
