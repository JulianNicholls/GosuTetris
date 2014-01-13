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
      super( WIDTH, HEIGHT, false, 125 )

      self.caption = 'Jetris'

      @fonts = ResourceLoader.fonts( self )

      reset
    end

    def reset
      @lines = 0
      @cur, @next = Shape.next( self ), Shape.next( self )
      @down_time  = 0
      @block_map  = BlockMap.new
      @down_set   = false
    end

    def update
      @down_time = (@down_time + 1) % 5   # Slow to begin with

      update_block_down if @down_time == 0 || @down_set

      @down_set = false
    end

    def update_block_down
      unless @cur.down( @block_map )   # Reached bottom or a block in the way
        @block_map.add( @cur.blocks )
        @lines += @block_map.complete_lines
        @cur  = @next
        @next = Shape.next( self )
      end
    end

    def draw
      draw_background
      draw_score
      @cur.draw
      @next.draw_absolute( NEXT_LEFT + BLOCK_SIDE, NEXT_TOP + BLOCK_SIDE )
      @block_map.draw( self )
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

    def button_down( btn_id )
      case btn_id
      when Gosu::KbEscape   then  close
      when Gosu::KbR        then  reset

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
