require 'constants'

module Tetris
  # Block Map, indexed Column then Row
  class BlockMap
    include Constants

    def initialize
      @blocks = Array.new(ROWS) { Array.new(COLUMNS, 0) }
    end

    def empty?(gpoint)
      gpoint.valid? && at(gpoint) == 0
    end

    def add(blocks)
      blocks.each do |block|
        @blocks[block[:y]][block[:x]] = block[:colour]
      end
    end

    def game_over?
      # Check for completion, i.e. Are there blocks in top row.

      !@blocks[0].all? { |colour| colour == 0 }
    end

    # Check for complete lines from the bottom to the top and
    # return the number removed

    def complete_lines
      row = ROWS - 1
      lines_removed = 0

      loop do
        while full_line(row)
          remove_line(row)
          lines_removed += 1
        end

        break if (row -= 1) < 1
      end

      lines_removed
    end

    # Draw the occupied blocks, with no outer line.

    def draw
      @blocks.each_with_index do |columns, idx|
        draw_row(columns, idx)
      end
    end

    private

    def at(gpoint)
      fail 'Invalid GPoint' unless gpoint.valid?

      @blocks[gpoint.row][gpoint.column]
    end

    def full_line(row)
      !@blocks[row].any? { |colour| colour == 0 }
    end

    # Remove a line, dropping down all the lines above

    def remove_line(start_row)
      start_row.downto(1).each { |row| @blocks[row] = @blocks[row - 1] }
      @blocks[0] = Array.new(COLUMNS, 0)
    end

    def draw_row(row, row_idx)
      row.each_with_index do |colour, idx|
        next if colour == 0

        gpoint = GridPoint.new(row_idx, idx)
        Block.draw(gpoint, colour, 0)
      end
    end
  end
end
