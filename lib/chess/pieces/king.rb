# frozen_string_literal: true

module Chess
  # Can move in any immediately surrounding positions
  class King < Piece
    def movement_set
      { offset: [
        [-1, 1], [0, 1], [1, 1],
        [-1, 0], [1, 0],
        [-1, -1], [0, -1], [1, -1]
      ] }
    end
  end
end
