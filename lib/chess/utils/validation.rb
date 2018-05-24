# frozen_string_literal: true

module Chess
  # Base module error
  class ChessError < StandardError; end
  # Raised when argument class is invalid
  class ArgumentClass < ChessError; end
  # Raised when argument is blank but a value was expected
  class EmptyArgument < ChessError; end
  # Raised when argument type is invalid
  class UnknownType < ChessError; end

  # Error raising helper mixin
  module Validation
    # Raises Chess::ArgumentClass if obj is NOT an instance of class
    def validate_class(obj, klass)
      return if obj.is_a? klass
      raise ArgumentClass, "#{obj} must be a #{klass}"
    end

    # Raises Chess::EmptyArgument if obj is falsey or empty
    def validate_presence_of(obj)
      return if obj.respond_to?(:empty?) ? !obj.empty? : !obj.nil?
      raise EmptyArgument, "#{obj} must not be blank"
    end

    # Raies Chess::UnknownType in type is not included in possible types
    def validate_included(type, all_types)
      return if all_types.include? type
      raise UnknownType, "#{type} is not included in #{all_types}"
    end
  end
end
