# frozen_string_literal: true

module Chess
  # Can move to positions based on an L-shape
  class Knight < Piece
    def movement_set
      { offset: [
        [-1, 2], [1, 2],
        [-2, 1], [2, 1],
        [-2, -1], [2, -1],
        [-1, -2], [1, -2]
      ] }
    end
  end
end
