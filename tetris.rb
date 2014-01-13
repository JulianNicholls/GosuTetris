# Tetris

require './gosu_enhanced'
require './constants'
require './resources'
require './shapes'
require './blockmap'
require './block'

module Tetris
  # Tetris Game

  class Game < Gosu::Window
    include Constants

    def initialize
      super( WIDTH, HEIGHT, false, 100 )

      self.caption = 'Gosu Tetris'

      @fonts = ResourceLoader.fonts( self )

      reset
    end

    def reset
      @lines = 0
      @cur, @next = Shape.next( self ), Shape.next( self )
      @down_time  = 0
      @stack      = BlockMap.new
      @down_set   = false
      @level      = 7     # Slow to begin with
      @paused     = false
    end

    def update
      unless @paused
        @down_time = (@down_time + 1) % @level

        update_block_down if @down_time == 0 || @down_set

        @down_set = false
      end
    end

    def update_block_down
      unless @cur.down( @stack )   # Reached bottom or a block in the way
        @stack.add( @cur.blocks )
        @lines += @stack.complete_lines
        @level  = [2, 7 - @lines / 10].max   # Speed up
        @cur    = @next
        @next   = Shape.next( self )
      end
    end

    def draw
      draw_background
      draw_score
      @stack.draw( self )
      @cur.draw
      @next.draw_absolute( NEXT_LEFT + BLOCK_SIDE, NEXT_TOP + BLOCK_SIDE )

      draw_paused if @paused
    end

    def draw_background
      draw_rectangle( 0, 0, WELL_BORDER, HEIGHT, 0, BACKGROUND )
      draw_rectangle( 9, HEIGHT - WELL_BORDER, WIDTH, WELL_BORDER, 0, BACKGROUND )
      draw_rectangle( WELL_BORDER + COLUMNS * BLOCK_SIDE, 0,
                      PANEL_WIDTH, HEIGHT, 0,
                      BACKGROUND )

      draw_rectangle( NEXT_LEFT, NEXT_TOP, NEXT_WIDTH, NEXT_HEIGHT, 0,
                      Gosu::Color::BLACK )

      draw_grid
    end

    def draw_grid
      (WELL_BORDER + BLOCK_SIDE)
        .step( WELL_BORDER + (COLUMNS - 1) * BLOCK_SIDE, BLOCK_SIDE )
        .each do |l|
        draw_rectangle( l, 0, 2, HEIGHT - WELL_BORDER, 0, GRID )
      end

      0.step( HEIGHT - (WELL_BORDER + 1), BLOCK_SIDE ).each do |t|
        draw_rectangle( WELL_BORDER, t, COLUMNS * BLOCK_SIDE, 2, 0, GRID )
      end
    end

    def draw_score
      @fonts[:score].draw( "Lines: #{@lines}", SCORE_LEFT, SCORE_TOP, 1,
                           1, 1, Gosu::Color::WHITE )
    end

    def draw_paused
      draw_rectangle( 60, 110, WIDTH - 120, HEIGHT - 220, 10, 0x60ffffff )
      p     = "PAUSED"
      font  = @fonts[:pause]

      width, height = font.measure( p )

      font.draw( "PAUSED", (WIDTH - width) / 2, (HEIGHT - height) / 2, 10,
                 1, 1, BLUE )
    end

    def button_down( btn_id )
      case btn_id
      when Gosu::KbEscape   then  close
      when Gosu::KbR        then  reset
      when Gosu::KbP        then  @paused = !@paused

      when Gosu::KbDown     then  @down_set = true
      when Gosu::KbLeft     then  @cur.left
      when Gosu::KbRight    then  @cur.right
      when Gosu::KbUp       then  @cur.rotate
      end
    end
  end
end

window = Tetris::Game.new
window.show
