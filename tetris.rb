# Tetris

require './gosu_enhanced'
require './constants'
require './resources'
require './shapes'
require './blockmap'
require './block'
require './pausewindow'
require './gameover'

module Tetris
  # Tetris Game

  class Game < Gosu::Window
    include Constants

    KEY_FUNCS = {
      Gosu::KbEscape   =>  :close,
      Gosu::KbR        =>  :reset,
      Gosu::KbP        =>  :toggle_paused,

      Gosu::KbDown     =>  :user_pressed_down,
      Gosu::KbLeft     =>  :move_left,
      Gosu::KbRight    =>  :move_right,
      Gosu::KbUp       =>  :rotate
    }

    def initialize
      super( WIDTH, HEIGHT, false, 100 )

      self.caption = 'Gosu Tetris'

      @fonts = ResourceLoader.fonts( self )

      reset
    end

    def reset
      @lines        = 0
      @cur, @next   = Shape.next( self ), Shape.next( self )
      @down_time    = 0
      @stack        = BlockMap.new
      @down_pressed = false
      @level        = 7     # Slow to begin with
      @paused       = false
      @game_over    = false
    end

    def update
      unless @paused || @game_over
        @down_time = (@down_time + 1) % @level

        update_block_down if @down_time == 0 || @down_pressed

        @down_pressed = false
      end

      @game_over = @stack.game_over?
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
      @next.draw_absolute(
        Point.new( NEXT_LEFT + BLOCK_SIDE, NEXT_TOP + BLOCK_SIDE ) )

      draw_paused     if @paused && !@game_over
      draw_game_over  if @game_over
    end

    def draw_background
      draw_rectangle( Point.new( 0, 0 ), Size.new( WELL_BORDER, HEIGHT ),
                      0, BACKGROUND )

      draw_rectangle( Point.new( 9, HEIGHT - WELL_BORDER ),
                      Size.new( WIDTH, WELL_BORDER ), 0, BACKGROUND )

      draw_rectangle( Point.new( WELL_BORDER + COLUMNS * BLOCK_SIDE, 0 ),
                      Size.new( PANEL_WIDTH, HEIGHT ), 0, BACKGROUND )

      draw_rectangle( Point.new( NEXT_LEFT, NEXT_TOP ),
                      Size.new( NEXT_WIDTH, NEXT_HEIGHT ),
                      0, Gosu::Color::BLACK )

      draw_grid
    end

    def draw_grid
      size = Size.new( 2, HEIGHT - WELL_BORDER )

      (WELL_BORDER + BLOCK_SIDE)
        .step( WELL_BORDER + (COLUMNS - 1) * BLOCK_SIDE, BLOCK_SIDE ).each do |l|
        draw_rectangle( Point.new( l, 0 ), size, 0, GRID )
      end

      size = Size.new( COLUMNS * BLOCK_SIDE, 2 )

      0.step( HEIGHT - (WELL_BORDER + 1), BLOCK_SIDE ).each do |t|
        draw_rectangle( Point.new( WELL_BORDER, t ), size, 0, GRID )
      end
    end

    def draw_score
      @fonts[:score].draw( "Lines: #{@lines}", SCORE_LEFT, SCORE_TOP, 1,
                           1, 1, Gosu::Color::WHITE )
    end

    def draw_paused
      PauseWindow.new( self ).draw
    end

    def draw_game_over
      GameOverWindow.new( self ).draw
    end

    def button_down( btn_id )
      send( KEY_FUNCS[btn_id] ) if KEY_FUNCS.key? btn_id
    end

    protected

    def toggle_paused
      @paused = !@paused
    end

    def user_pressed_down
      @down_pressed = true
    end

    def move_left
      @cur.left( @stack )
    end

    def move_right
      @cur.right( @stack )
    end

    def rotate
      @cur.rotate
    end
  end
end

window = Tetris::Game.new
window.show
