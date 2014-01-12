module Tetris
  # A Bar

  class Bar < Shape
    def initialize( window )
      super( window )

      @map = [
        [[0, 0], [1, 0], [2, 0], [3, 0]],
        [[0, 0], [0, 1], [0, 2], [0, 3]]
      ]
    end
  end

  # A T-shape

  class Tee < Shape
    def initialize( window )
      super( window )

      @map = [
        [[0, 0], [1, 0], [2, 0], [1, 1]],
        [[1, 0], [0, 1], [1, 1], [1, 2]],
        [[1, 0], [0, 1], [1, 1], [2, 1]],
        [[0, 0], [0, 1], [0, 2], [1, 1]]
      ]
    end
  end
end
