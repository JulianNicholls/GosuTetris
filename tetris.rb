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

    attr_reader :stack, :sounds

    KEY_FUNCS = {
      Gosu::KbEscape =>  :close,
      Gosu::KbR      =>  :reset,
      Gosu::KbP      =>  :toggle_paused,

      Gosu::KbDown   =>  :user_pressed_down,
      Gosu::KbLeft   =>  :move_left,
      Gosu::KbRight  =>  :move_right,
      Gosu::KbUp     =>  :rotate
    }

    def initialize( debug )
      super( WIDTH, HEIGHT, false, 100 )

      self.caption = 'Gosu Tetris'

      @fonts  = ResourceLoader.fonts( self )
      @images = ResourceLoader.images( self )
      @sounds = ResourceLoader.sounds( self )
      @debug  = debug

      reset
    end

    def reset
      @lines        = 0
      @down_time    = 0
      @stack        = BlockMap.new
      @cur, @next   = Shape.next( self ), Shape.next( self )
      @down_pressed = false
      @level        = 6     # Slow to begin with
      @paused       = false
      @game_over    = false
    end

    def update
      unless @paused || @game_over
        @down_time = (@down_time + 1) % @level

        update_block_down if (@down_time == 0 && !@debug) || @down_pressed

        @down_pressed = false
      end

      @game_over = @stack.game_over?
    end

    def update_block_down
      unless @cur.down       # Reached bottom or a block in the way
        @stack.add( @cur.blocks )

        clines = @stack.complete_lines
        unless clines == 0
          @sounds[:smash].play
          @lines += clines
        end

        @level      = [2, 6 - @lines / 10].max   # Speed up
        @cur, @next = @next, Shape.next( self )
      end
    end

    def draw
      draw_background
      draw_score
      @stack.draw( self )
      @cur.draw
      @next.draw_absolute( NEXT.offset( BLOCK_SIDE, BLOCK_SIDE ) )

      draw_overlays
    end

    def draw_background
      @images[:background].draw( 0, 0, 0 )
    end

    def draw_score
      @fonts[:score].draw( "Lines: #{@lines}", SCORE_LEFT, SCORE_TOP, 1,
                           1, 1, Gosu::Color::WHITE )
    end

    def draw_overlays
      if @game_over
        GameOverWindow.new( self ).draw
      elsif @paused
        PauseWindow.new( self ).draw
      end
    end

    def button_down( btn_id )
      send( KEY_FUNCS[btn_id] ) if KEY_FUNCS.key? btn_id
    end

    private

    def toggle_paused
      @paused = !@paused
    end

    def user_pressed_down
      @down_pressed = true
    end

    def move_left
      @cur.left
    end

    def move_right
      @cur.right
    end

    def rotate
      @cur.rotate
    end
  end
end

debug = ARGV.first == '--debug'
puts 'Debug Mode' if debug

window = Tetris::Game.new( debug )
window.show
