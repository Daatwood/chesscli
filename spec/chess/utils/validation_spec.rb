# frozen_string_literal: true

module Chess
  class DummyValidation
    extend Validation
  end
end

RSpec.describe Chess::DummyValidation do
  subject(:dummy) { described_class }

  describe '.validate_class' do
    it 'raises error when not instance of class' do
      expect { dummy.validate_class(123, String) }.to ensure_class_as String
    end

    it 'returns nil with correct class' do
      expect(dummy.validate_class(123, Integer)).to be_nil
    end
  end

  describe '.validate_presence_of' do
    context 'when blank argument' do
      it 'nil raises error ' do
        expect { dummy.validate_presence_of(nil) }.to ensure_presence
      end

      it 'empty array raises error ' do
        expect { dummy.validate_presence_of([]) }.to ensure_presence
      end

      it 'empty string raises error ' do
        expect { dummy.validate_presence_of('') }.to ensure_presence
      end
    end

    context 'when valid argument' do
      it 'array contains items returns nil' do
        expect(dummy.validate_presence_of([1])).to be_nil
      end

      it 'string has value returns nil' do
        expect(dummy.validate_presence_of('abc')).to be_nil
      end

      it 'zero returns nil' do
        expect(dummy.validate_presence_of(0)).to be_nil
      end
    end
  end

  describe '.validate_included' do
    let(:list) { %w[1 2 3] }

    it 'expects types to respond to include' do
      expect { dummy.validate_included(1, 123) }
        .to raise_error(NoMethodError, /include?/)
    end

    it 'raises error when not included' do
      expect { dummy.validate_included(5, list) }.to ensure_included
    end

    it 'returns nil when included' do
      expect(dummy.validate_included('1', list)).to be_nil
    end
  end
end
