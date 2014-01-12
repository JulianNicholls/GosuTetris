require './constants'

module Tetris
  # Block Map, indexed Column then Row

  class BlockMap
    include Constants

    def initialize
      @map = Array.new( ROWS, Array.new( COLUMNS, 0 ) )
    end

    def at( row, column )
      @map[row, column]
    end

    def empty?( row, column )
      at( row, column ) == 0
    end

    def draw( window )
      @map.each_with_index do |columns, ridx|
        columns.each_with_index do |colour, cidx|
          Block.draw( window, ridx, cidx, colour ) unless colour == 0
        end
      end
    end
  end
end
