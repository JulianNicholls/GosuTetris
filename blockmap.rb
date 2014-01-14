require './constants'

module Tetris
  # Block Map, indexed Column then Row

  class BlockMap
    include Constants

    def initialize
      @blocks = Array.new( ROWS ) { |idx| Array.new( COLUMNS, 0 ) }
    end

    def at( row, column )
      fail 'Invalid Row'    unless row.between?( 0, ROWS - 1 )
      fail 'Invalid Column' unless column.between?( 0, COLUMNS - 1 )

      @blocks[row][column]
    end

    def empty?( row, column )
      row < ROWS &&
      column.between?( 0, COLUMNS - 1 ) &&
      at( row, column ) == 0
    end

    def add( blocks )
      blocks.each { |b| @blocks[b[:row]][b[:column]] = b[:colour] }
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
          Block.draw( window, ridx, cidx, colour ) unless colour == 0
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
