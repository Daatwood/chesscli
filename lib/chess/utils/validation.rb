# frozen_string_literal: true

module Chess
  # Error raising helper mixin
  module Validation
    # Raises Chess::ArgumentType if obj is NOT an instance of class
    def validate_class(obj, klass)
      raise ArgumentType, "#{obj} must be a #{klass}" unless obj.is_a? klass
    end

    # Raises Chess::ArgumentType if obj is falsey or empty
    def validate_presence_of(obj)
      return if obj.respond_to?(:empty?) ? !obj.empty? : !obj.nil?
      raise ArgumentType, "#{obj} must not be blank"
    end

    # Raies Chess::UnknownType in type is not included in possible types
    def validate_included(type, all_types)
      return if all_types.include? type
      raise UnknownType, "#{type} is not included in #{all_types}"
    end
  end
end
