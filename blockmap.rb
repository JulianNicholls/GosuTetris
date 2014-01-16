require './constants'

module Tetris
  # Block Map, indexed Column then Row

  class BlockMap
    include Constants

    def initialize
      @blocks = Array.new( ROWS ) { |idx| Array.new( COLUMNS, 0 ) }
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

    # Check for complete lines from the bottom to the top

    def complete_lines
      row, lines_removed = ROWS - 1, 0

      loop do
        if @blocks[row].any? { |colour| colour == 0 }
          break if (row -= 1) < 1
        else
          remove_line( row )
          lines_removed += 1
        end
      end

      lines_removed
    end

    # Draw the occupied blocks

    def draw( window )
      @blocks.each_with_index do |columns, ridx|
        columns.each_with_index do |colour, cidx|
          unless colour == 0
            gpoint = GridPoint.new( ridx, cidx )
            Block.draw( window, gpoint, colour )
          end
        end
      end
    end

    protected

    # Remove a line, dropping down all the lines above

    def remove_line( row )
      row.downto( 1 ).each { |r| @blocks[r] = @blocks[r - 1] }
      @blocks[0] = Array.new( COLUMNS, 0 )
    end
  end
end
