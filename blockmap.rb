require 'constants'

module Tetris
  # Block Map, indexed Column then Row
  class BlockMap
    include Constants

    def initialize
      @blocks = Array.new( ROWS ) { Array.new( COLUMNS, 0 ) }
    end

    def at( gpoint )
      fail 'Invalid Row'    unless gpoint.row.between?( 0, ROWS - 1 )
      fail 'Invalid Column' unless gpoint.column.between?( 0, COLUMNS - 1 )

      @blocks[gpoint.row][gpoint.column]
    end

    def empty?( gpoint )
      gpoint.row < ROWS &&
      gpoint.column.between?( 0, COLUMNS - 1 ) &&
      at( gpoint ) == 0
    end

    def add( blocks )
      blocks.each { |b| @blocks[b[:gpoint].row][b[:gpoint].column] = b[:colour] }
    end

    def game_over?
      # Check for completion, i.e. Are there blocks in top row.

      !@blocks[0].all? { |colour| colour == 0 }
    end

    # Check for complete lines from the bottom to the top and
    # return the number removed

    def complete_lines( noise )
      row, lines_removed = ROWS - 1, 0

      loop do
        while full_line( row )
          remove_line( row )
          noise.play
          lines_removed += 1
        end

        break if (row -= 1) < 1
      end

      lines_removed
    end

    # Draw the occupied blocks, with no outer line.

    def draw( window )
      @blocks.each_with_index do |columns, ridx|
        columns.each_with_index do |colour, cidx|
          next if colour == 0

          gpoint = GridPoint.new( ridx, cidx )
          Block.draw( window, gpoint, colour, 0 )
        end
      end
    end

    private

    def full_line( row )
      !@blocks[row].any? { |colour| colour == 0 }
    end

    # Remove a line, dropping down all the lines above

    def remove_line( row )
      row.downto( 1 ).each { |r| @blocks[r] = @blocks[r - 1] }
      @blocks[0] = Array.new( COLUMNS, 0 )
    end
  end
end
