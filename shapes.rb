# Shapes

require './block'

module Tetris
  # Base class for the four shapes

  class Shape
    include Constants

    @prev_colour = -1

    def initialize( window )
      @window = window
      @colour = Shape.colour  # Random Colour
      @orient = 0
      @origin = GridPoint.new( 0, 3 )
    end

    def self.next( window )
      case rand( 1..5 )
      when 1 then RightEll.new( window )
      when 2 then LeftEll.new( window )
      when 3 then Tee.new( window )
      when 4 then Bar.new( window )
      when 5 then Square.new( window )
      end
    end

    # Return a random colour, but a different one from the immediately
    # previous one

    def self.colour
      colour = rand( 0..5 )

      colour = (colour + 1) % 6 if colour == @prev_colour
      @prev_colour = colour

      [RED, GREEN, BLUE, PURPLE, AQUA, YELLOW][colour]
    end

    def rotate
      @orient = (@orient + 1) % @map.size if rotatable?
    end

    def down
      ok = downable?

      # If we can move, but are now at the bottom then make a noise

      if ok
        @origin.move_by!( 1, 0 )
        @window.sounds[:drop].play if !downable?
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
      stack = @window.stack
      @map[@orient].all? do |point|
        stack.empty?( @origin.offset( point[1], point[0] + 1 ) )
      end
    end

    def leftable?
      stack = @window.stack
      @map[@orient].all? do |point|
        stack.empty?( @origin.offset( point[1], point[0] - 1 ) )
      end
    end

    def downable?
      stack = @window.stack
      @map[@orient].all? do |point|
        stack.empty?( @origin.offset( point[1] + 1, point[0] ) )
      end
    end

    def rotatable?
      stack = @window.stack
      @map[(@orient + 1) % @map.size].all? do |point|
        stack.empty?( @origin.offset( point[1], point[0] ) )
      end
    end
  end
end

require './dropshapes'
