# Shapes

require './block'

module Tetris
  # Base class for the four shapes

  class Shape
    include Constants

    attr_reader :left, :top

    @prev_colour = -1

    def initialize( window )
      @window = window
      @colour = Shape.colour  # Random Colour
      @orient = 0
      @left, @top = 3, 0
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

      colour = rand( 0..5 ) while colour == @prev_colour
      @prev_colour = colour

      [RED, GREEN, BLUE, PURPLE, AQUA, YELLOW][colour]
    end

    def rotate
      @orient = (@orient + 1) % @map.size
    end

    def down( block_map )
      ok = downable( block_map )
      @top += 1 if ok

      ok    # Return whether we moved so that we know when the bottom is reached
    end

    def right
      @left += 1 if rightable?
    end

    # TODO check whether there's anything in the way
    def left
      @left -= 1 if @left > 0
    end

    def width
      @map[@orient].map { |p| p[0] }.max + 1
    end

    def blocks
      @map[@orient].map do |point|
        {
          row:    @top + point[1],
          column: @left + point[0],
          colour: @colour
        }
      end
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

    protected

    # TODO check whether there's anything in the way as well
    def rightable?
      @left + width < COLUMNS
    end

    def downable( block_map )
      @map[@orient].all? do |point|
        block_map.empty?( point[1] + @top + 1, point[0] + @left )
      end
    end
  end
end

require './dropshapes'
