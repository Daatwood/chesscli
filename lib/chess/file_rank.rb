# frozen_string_literal: true

module Chess
  # A representation of a chessboard position
  class FileRank
    extend Chess::Validation

    FILE_RANGE = 'a'..'h'
    RANK_RANGE = '1'..'8'

    class << self
      # Creates an instance from string. Example 'a1'
      def from_string(file_rank_string)
        validate_class file_rank_string, String
        validate_presence_of file_rank_string

        return nil unless valid_position?(file_rank_string)
        file, rank = split file_rank_string
        new(file.to_sym, rank.to_i)
      end

      # Creates an instance from index positions of file and rank.
      def from_indexes(file_index, rank_index)
        return nil unless valid_indexes?(file_index, rank_index)

        new(files[file_index], ranks[rank_index])
      end

      # Determines if string of file and rank is within valid range
      def valid_position?(file_rank_string)
        return false if file_rank_string.nil? || !file_rank_string.is_a?(String)
        file, rank = split file_rank_string
        FILE_RANGE.include?(file) && RANK_RANGE.include?(rank)
      end

      # Determines if file and rank indexes are valid
      def valid_indexes?(file_index, rank_index)
        validate_class file_index, Integer

        validate_class rank_index, Integer

        (file_index > -1 && file_index < files.size) &&
          (rank_index > -1 && rank_index < ranks.size)
      end

      # An array of valid files as symbols
      def files
        @files ||= FILE_RANGE.map(&:to_sym)
      end

      # An array of valid ranks as integers
      def ranks
        @ranks ||= RANK_RANGE.map(&:to_i)
      end

      private

      # Regex split any non-digit and digit
      def split(file_rank_string)
        file_rank_string.downcase.scan(/[a-z]+|(?<=[a-z]).*/)
      end
    end

    # Do not use `.new`
    # Use `.from_string` or `.from_indexes`
    # This will ensure the position is both a valid file and rank
    private_class_method :new

    # File and Ranks are read-only to prevent setting invalid positions
    # Could add custom setters for file and rank to validate positions
    attr_reader :file, :rank

    def initialize(file, rank)
      @file = file
      @rank = rank
    end

    def file_index
      @file_index ||= self.class.files.index(@file)
    end

    def rank_index
      @rank_index ||= self.class.ranks.index(@rank)
    end

    def to_s
      "#{@file}#{@rank}"
    end
  end
end
