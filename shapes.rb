require './block'
require './constants'

module Tetris
  # Base class for the shapes

  class Shape
    include Constants
    
    def initialize( window )
      @window = window
      @orient = 0
      @origin = GridPoint.new( 0, 3 )
    end

    def self.next( window )
      case rand( 1..7 )
      when 1 then RightEll.new( window )
      when 2 then LeftEll.new( window )
      when 3 then Tee.new( window )
      when 4 then Bar.new( window )
      when 5 then Square.new( window )
      when 6 then LeftSnake.new( window )
      when 7 then RightSnake.new( window )
      end
    end

    def rotate
      @orient = (@orient + 1) % @map.size if rotatable?
    end

    def down
      ok = downable?

      # If we can move, but are then at the bottom, make a noise

      if ok
        @origin.move_by!( 1, 0 )
        @window.sounds[:drop].play unless downable?
      end

      ok    # Return whether we moved so that we know when the bottom is reached
    end

    def right
      @origin.move_by!( 0, 1 ) if rightable?
    end

    def left
      @origin.move_by!( 0, -1 ) if leftable?
    end

    def width
      @map[@orient].map { |p| p[0] }.max + 1
    end

    def height
      @map[@orient].map { |p| p[1] }.max + 1
    end

    def blocks
      @map[@orient].map do |point|
        {
          gpoint: @origin.offset( point[1], point[0] ),
          colour: @colour
        }
      end
    end

    def draw
      @map[@orient].each do |point|
        Block.draw( @window, @origin.offset( point[1], point[0] ), @colour )
      end
    end

    # Draw at a specific pixel position in the default orientation

    def draw_absolute( porigin )
      @map[0].each do |point|
        Block.draw_absolute(
          @window, porigin.offset( point[0] * BLOCK_SIDE, point[1] * BLOCK_SIDE ),
          @colour )
      end
    end

    private

    def rightable?
      moveable?( 0, 1 )
    end

    def leftable?
      moveable?( 0, -1 )
    end

    def downable?
      moveable?( 1, 0 )
    end

    def rotatable?
      moveable?( 0, 0, (@orient + 1) % @map.size )
    end
    
    def moveable?( y_delta, x_delta, o_value = @orient )
      stack = @window.stack
      @map[o_value].all? do |point|
        stack.empty?( @origin.offset( point[1] + y_delta, point[0] + x_delta ) )
      end
      
    end
  end
end

require './dropshapes'
