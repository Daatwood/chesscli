# frozen_string_literal: true

module Chess
  # Base module error
  class ChessError < StandardError; end
  # Raised when argument is invalid
  class ArgumentType < ChessError; end
  # Raised when type is invalid
  class UnknownType < ChessError; end
end
