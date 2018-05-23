# frozen_string_literal: true

module Chess
  class ChessError < StandardError; end
  class ArgumentType < ChessError; end
  class UnknownType < ChessError; end
end
