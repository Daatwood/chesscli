# frozen_string_literal: true

module Chess
  # Calculates the possible positions from initial position given movement set
  class Movement
    extend Chess::Validation

    # Do not use `.new`
    # TODO refactor into a singleton / service class
    private_class_method :new

    class << self
      # Creates a valid type list of movement actions
      def types
        @types ||= methods.grep(/move_as_/) do |func|
          func.to_s.gsub(/move_as_/, '').downcase.to_sym
        end
      end

      # Offsets a file and rank  with given amount, returning nil if new
      # position is not valid
      def move_as_offset(file_rank, file_offset, rank_offset)
        FileRank.from_indexes(file_rank.file_index + file_offset,
                              file_rank.rank_index + rank_offset)
      end

      # Continually adds offset to previously calculated file and rank until nil
      # or is the same as last. Reutrns an array
      def move_as_ray(file_rank, file_offset, rank_offset)
        set = []
        while (file_rank = move_as_offset(file_rank, file_offset, rank_offset))
          break if set.last == file_rank # Break out, not going anywhere..
          set << file_rank
        end
        set
      end

      # Accepts a `FileRank` and a `Hash` containing `ray` or `offset` keys
      # Value of a key is an array containing an array of file and rank offsets
      def project(file_rank, movement_set)
        validate_class movement_set, Hash
        validate_class file_rank, FileRank
        movement_set.each_with_object([]) do |(move_type, offsets), positions|
          validate_included move_type.downcase, types
          move_func = move_type.to_s.prepend('move_as_')
          offsets.each do |offset|
            positions << public_send(move_func, file_rank, *offset)
          end
        end.flatten.compact
      end
    end
  end
end
