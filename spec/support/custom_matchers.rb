# frozen_string_literal: true

RSpec::Matchers.define :have_constant do |const|
  match do |actual|
    actual.const_defined?(const)
  end

  description do
    'have constant defined'
  end
end

RSpec::Matchers.define :reassign do |attribute|
  match do |actual|
    actual.respond_to?("#{attribute}=")
  end

  description do
    "be able to reassign #{attribute}"
  end
end

RSpec::Matchers.define :ensure_class_as do |klass|
  match do
    raise_error(Chess::ArgumentClass, /be a #{klass}/)
  end
  description do
    "raise error when not #{klass}"
  end

  supports_block_expectations
end

RSpec::Matchers.define :ensure_presence do
  match do
    raise_error(Chess::EmptyArgument, /not be blank/)
  end
  description do
    'raise error when blank'
  end

  supports_block_expectations
end

RSpec::Matchers.define :ensure_included do
  match do
    raise_error(Chess::UnknownType, /not included in/)
  end
  description do
    'raise error when wrong type'
  end

  supports_block_expectations
end
