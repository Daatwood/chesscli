# frozen_string_literal: true

module Chess
  # Can move in any diagonal positions
  class Bishop < Piece
    def movement_set
      { ray: [
        [-1, 1], [1, 1], [-1, -1], [1, -1]
      ] }
    end
  end
end
