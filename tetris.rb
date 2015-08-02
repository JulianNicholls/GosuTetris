#! /usr/bin/env ruby -I.

require 'gosu_enhanced'

require 'constants'
require 'resources'
require 'shapes'
require 'blockmap'
require 'block'
require 'pausewindow'
require 'gameover'

module Tetris
  # Tetris Game
  class Game < Gosu::Window
    include Constants

    attr_reader :stack, :sounds

    KEY_FUNCS = {
      Gosu::KbEscape =>  -> { close if @debug || @game_over },
      Gosu::KbR      =>  -> { reset if @debug || @game_over },
      Gosu::KbP      =>  -> { @paused = !@paused },

      Gosu::KbDown   =>  -> { @down_pressed = true },
      Gosu::KbLeft   =>  -> { @cur.left },
      Gosu::KbRight  =>  -> { @cur.right },
      Gosu::KbUp     =>  -> { @cur.rotate }
    }

    def initialize(debug)
      super(WIDTH, HEIGHT, false, 60)

      self.caption = 'Gosu Tetris'

      loader = ResourceLoader.new(self)

      @fonts  = loader.fonts
      @images = loader.images
      @sounds = loader.sounds
      @debug  = debug

      reset
    end

    def update
      unless @paused || @game_over
        @down_time = (@down_time + 1) % @level

        update_block_down if (@down_time == 0 && !@debug) || @down_pressed

        @down_pressed = false
      end

      @game_over = @stack.game_over?
    end

    def draw
      draw_background
      draw_score
      @stack.draw(self)
      @cur.draw
      @next.draw_absolute(NEXT_POS.offset(BLOCK_SIDE, BLOCK_SIDE))

      draw_overlays
    end

    def button_down(btn_id)
      instance_exec(&KEY_FUNCS[btn_id]) if KEY_FUNCS.key? btn_id
    end

    private

    def reset
      @lines        = 0
      @down_time    = 0
      @stack        = BlockMap.new
      @cur          = Shape.next(self)
      @next         = Shape.next(self)
      @down_pressed = false
      @level        = 10     # Slow to begin with
      @paused       = false
      @game_over    = false
    end

    def update_block_down
      return if @cur.down       # Not reached bottom or a block in the way

      @stack.add(@cur.blocks)

      removed = @stack.complete_lines
      @sounds[:smash].play if removed > 0
      @lines += removed

      @level      = [2, 10 - @lines / 10].max   # Speed up
      @cur        = @next
      @next       = Shape.next(self)
    end

    def draw_background
      @images[:background].draw(0, 0, 0)
    end

    def draw_score
      @fonts[:score].draw("Lines: #{@lines}", SCORE_LEFT, SCORE_TOP, 1,
                          1, 1, Gosu::Color::WHITE)
    end

    def draw_overlays
      return GameOverWindow.new(self).draw if @game_over

      PauseWindow.new(self).draw if @paused
    end
  end
end

debug = ARGV.first == '--debug'
puts 'Debug Mode' if debug

window = Tetris::Game.new(debug)
window.show
