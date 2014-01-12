module Tetris
  # A Right-handed Ell

  class RightEll < Shape
    MAP = [
      [[0, 0], [1, 0], [2, 0], [0, 1]],
      [[0, 0], [1, 0], [1, 1], [1, 2]],
      [[2, 0], [0, 1], [1, 1], [2, 1]],
      [[0, 0], [0, 1], [0, 2], [1, 2]]
    ]

    def draw
      MAP[@orient].each do |point|
        draw_block( WELL_BORDER + (@left + point[0]) * BLOCK_SIDE,
                    (@top + point[1]) * BLOCK_SIDE )
      end
    end

    # Draw at a specific place in the default orientation

    def draw_absolute( left, top )
      MAP[0].each do |point|
        draw_block( left + point[0] * BLOCK_SIDE, top + point[1] * BLOCK_SIDE )
      end
    end
  end

  # A Left-handed Ell

  class LeftEll < Shape
    MAP = [
      [[0, 0], [1, 0], [2, 0], [2, 1]],
      [[0, 0], [1, 0], [2, 1], [1, 2]],
      [[0, 0], [0, 1], [1, 1], [2, 1]],
      [[0, 0], [1, 0], [0, 1], [0, 2]]
    ]

    def draw
      MAP[@orient].each do |point|
        draw_block( WELL_BORDER + (@left + point[0]) * BLOCK_SIDE,
                    (@top + point[1]) * BLOCK_SIDE )
      end
    end

    # Draw at a specific place in the default orientation

    def draw_absolute( left, top )
      MAP[0].each do |point|
        draw_block( left + point[0] * BLOCK_SIDE, top + point[1] * BLOCK_SIDE )
      end
    end
  end
end
