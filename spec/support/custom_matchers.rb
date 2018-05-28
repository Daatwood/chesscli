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

RSpec::Matchers.define :terminate do |_code|
  actual_code = nil
  supports_block_expectations

  match do |block|
    begin
      block.call
    rescue SystemExit => e
      actual_code = e.status
    end
    actual_code && actual_code == status_code
  end

  chain :with_code do |status_code|
    @status_code = status_code
  end

  failure_message do |_block|
    "expected block to call exit(#{status_code}) but exit" +
      (actual_code.nil? ? ' not called' : "(#{actual_code}) was called")
  end

  failure_message_when_negated do |_block|
    "expected block not to call exit(#{status_code})"
  end

  description do
    "expect block to call exit(#{status_code})"
  end

  def status_code
    @status_code ||= 0
  end
end
