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
      
      @colour = ORANGE
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
      
      @colour = BLUE
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
      
      @colour = CYAN
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
      
      @colour = PURPLE
    end
  end

  # A Square

  class Square < Shape
    def initialize( window )
      super( window )

      @map = [
        [[0, 0], [1, 0], [0, 1], [1, 1]]
      ]
      
      @colour = YELLOW
    end
  end
  
  # A left snake / stair

  class LeftSnake < Shape
    def initialize( window )
      super( window )

      @map = [
        [[0, 0], [1, 0], [1, 1], [2, 1]],
        [[1, 0], [0, 1], [1, 1], [0, 2]]
      ]
      
      @colour = RED
    end
  end
  
  # A right snake / stair

  class RightSnake < Shape
    def initialize( window )
      super( window )

      @map = [
        [[1, 0], [2, 0], [0, 1], [1, 1]],
        [[0, 0], [0, 1], [1, 1], [1, 2]]
      ]
      
      @colour = GREEN
    end
  end
end
