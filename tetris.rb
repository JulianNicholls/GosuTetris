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
      Gosu::KbEscape =>  -> { close if @debug },
      Gosu::KbR      =>  -> { reset if @debug || @game_over },
      Gosu::KbP      =>  -> { @paused = !@paused },

      Gosu::KbDown   =>  -> { @down_pressed = true },
      Gosu::KbLeft   =>  -> { @cur.left },
      Gosu::KbRight  =>  -> { @cur.right },
      Gosu::KbUp     =>  -> { @cur.rotate }
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

        @lines += @stack.complete_lines( @sounds[:smash] )

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
      GameOverWindow.new( self ).draw && return if @game_over

      PauseWindow.new( self ).draw if @paused
    end

    def button_down( btn_id )
      instance_exec( &KEY_FUNCS[btn_id] )
    end
  end
end

debug = ARGV.first == '--debug'
puts 'Debug Mode' if debug

window = Tetris::Game.new( debug )
window.show
