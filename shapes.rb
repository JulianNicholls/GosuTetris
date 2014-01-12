# Shapes

require './block'

module Tetris
  # Base class for the four shapes

  class Shape
    include Constants

    attr_reader :left, :top

    def initialize( window )
      @window = window
      @colour = Shape.colour  # Random Colour
      @orient = 0
      @left, @top = 3, 0
    end

    def self.next( window )
      case rand( 1..4 )
      when 1 then RightEll.new( window )
      when 2 then LeftEll.new( window )
      when 3 then Tee.new( window )
      when 4 then Bar.new( window )
      end
    end

    def self.colour
      [RED, GREEN, BLUE, PURPLE][rand 0..3]
    end

    def rotate
      @orient = (@orient + 1) % @map.size
    end

    def down
      @top += 1
    end

    def right
      @left += 1 if rightable?
    end

    def left
      @left -= 1 if @left > 0
    end

    def rightable?
      @left + width < COLUMNS
    end

    def width
      @map[@orient].map { |p| p[0] }.max + 1
    end

    def draw
      @map[@orient].each do |point|
        Block.draw( @window, @top + point[1], @left + point[0], @colour )
      end
    end

    # Draw at a specific place in the default orientation

    def draw_absolute( left, top )
      @map[0].each do |point|
        Block.draw_absolute(
          @window,
          left + point[0] * BLOCK_SIDE, top + point[1] * BLOCK_SIDE,
          @colour )
      end
    end
  end
end

require './ells'
require './teabar'
