# frozen_string_literal: true

module Chess
  # Can move to any horizontal, vertical, or any diagonal positions
  class Queen < Piece
    def movement_set
      { ray: [
        [-1, 1], [0, 1], [1, 1],
        [-1, 0], [1, 0],
        [-1, -1], [0, -1], [1, -1]
      ] }
    end
  end
end
