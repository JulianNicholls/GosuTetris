module Tetris
  # A Right-handed Ell

  class RightEll < Shape
    def initialize( window )
      super( window )

      @map = [
        [[0, 0], [1, 0], [2, 0], [0, 1]],
        [[0, 0], [1, 0], [1, 1], [1, 2]],
        [[2, 0], [0, 1], [1, 1], [2, 1]],
        [[0, 0], [0, 1], [0, 2], [1, 2]]
      ]
    end
  end

  # A Left-handed Ell

  class LeftEll < Shape
    def initialize( window )
      super( window )

      @map = [
        [[0, 0], [1, 0], [2, 0], [2, 1]],
        [[0, 2], [1, 0], [1, 1], [1, 2]],
        [[0, 0], [0, 1], [1, 1], [2, 1]],
        [[0, 0], [1, 0], [0, 1], [0, 2]]
      ]
    end
  end

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

  # A Square

  class Square < Shape
    def initialize( window )
      super( window )

      @map = [
        [[0, 0], [1, 0], [0, 1], [1, 1]]
      ]
    end
  end
  
  # A left snake

  class LeftSnake < Shape
    def initialize( window )
      super( window )

      @map = [
        [[0, 0], [1, 0], [1, 1], [2, 1]],
        [[1, 0], [0, 1], [1, 1], [0, 2]]
      ]
    end
  end
  
  # A right snake

  class RightSnake < Shape
    def initialize( window )
      super( window )

      @map = [
        [[1, 0], [2, 0], [0, 1], [1, 1]],
        [[0, 0], [0, 1], [1, 1], [1, 2]]
      ]
    end
  end
end
