# Tetris

require './gosu_enhanced'
require './constants'
require './resources'
require './shapes'

module Tetris
  # Tetris Game

  class Game < Gosu::Window
    include Constants

    def initialize
      super( WIDTH, HEIGHT, false, 250 )

      self.caption = 'Jetris'

      @fonts = ResourceLoader.fonts( self )

      reset
    end

    def reset
      @lines = 0
      @cur, @next = Shape.next( self ), Shape.next( self )
    end

    def update
      # Bugger all
    end

    def draw
      draw_background
      draw_score
      @cur.draw
      @next.draw_absolute( NEXT_LEFT + BLOCK_SIDE, NEXT_TOP + BLOCK_SIDE )
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

      when Gosu::KbDown     then  @cur.down
      when Gosu::KbLeft     then  @cur.left
      when Gosu::KbRight    then  @cur.right
      when Gosu::KbUp       then  @cur.rotate
      end
    end
  end
end

window = Tetris::Game.new
window.show
