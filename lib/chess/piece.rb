# frozen_string_literal: true

module Chess
  # Base class for any chess piece
  class Piece
    extend Chess::Validation

    class << self
      # Transcend into Space and Memory and fetches all subclasses
      def descendants
        @descendants ||= ObjectSpace.each_object(Class).select do |klass|
          klass < self
        end
      end

      # Creates a valid list of types from subclasses
      def types
        @types ||= descendants.map do |klass|
          klass.to_s.split('::').last.downcase
        end
      end

      # Returns an instance chess piece with given name
      def from_string(piece_string)
        validate_class piece_string, String
        piece_string = piece_string.strip.freeze
        validate_included piece_string.downcase, types
        Object.const_get("Chess::#{piece_string.capitalize}").new
      end
    end

    # Returns an array of strings as positions
    def available_moves(file_rank_string)
      file_rank = FileRank.from_string(file_rank_string)
      Movement.project(file_rank, movement_set).map(&:to_s).sort_by(&:reverse)
    end
  end
end
