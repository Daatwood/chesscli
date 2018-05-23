# frozen_string_literal: true

RSpec::Matchers.define :have_constant do |const|
  match do |actual|
    actual.const_defined?(const)
  end
end

RSpec::Matchers.define :be_assigning do |attribute|
  match do |actual|
    actual.respond_to?("#{attribute}=")
  end

  match_when_negated do |actual|
    !actual.respond_to?("#{attribute}=")
  end
end

RSpec::Matchers.define :validate_class_as do |klass|
  match do
    raise_error(Chess::ArgumentType, /be a #{klass}/)
  end

  supports_block_expectations
end

RSpec::Matchers.define :validate_presense do
  match do
    raise_error(Chess::ArgumentType, /not be blank/)
  end

  supports_block_expectations
end

RSpec::Matchers.define :validate_included_in do |array|
  match do
    raise_error(Chess::UnknownType, /not included in #{array.join(', ')}/)
  end

  supports_block_expectations
end
