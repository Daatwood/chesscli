# frozen_string_literal: true

module Chess
  # Can move to any horizontal or vertical positions
  class Rook < Piece
    def movement_set
      { ray: [
        [0, 1], [-1, 0], [1, 0], [0, -1]
      ] }
    end
  end
end
