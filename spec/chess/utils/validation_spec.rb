# frozen_string_literal: true

module Chess
  describe 'Validation Test' do
    class Dummy
      extend Chess::Validation
    end
    subject(:dummy) { Dummy }

    describe '.validate_class' do
      it 'an instance of class' do
        expect { dummy.validate_class(123, String) }
          .to raise_error(ArgumentType, /must be a/)
      end

      it 'returns nil with correct class' do
        expect(dummy.validate_class(123, Integer)).to be_nil
      end
    end

    describe '.validate_presence_of' do
      it 'raises error when falsey' do
        expect { dummy.validate_presence_of(nil) }
          .to raise_error(ArgumentType, /not be blank/)
      end

      it 'raises error when empty' do
        expect { dummy.validate_presence_of('') }
          .to raise_error(ArgumentType, /not be blank/)
      end

      it 'returns nil when not empty or falsy' do
        expect(dummy.validate_presence_of('string')).to be_nil
      end
    end

    describe '.validate_included' do
      let(:list) { %w[1 2 3] }
      it 'expects types to respond to include' do
        expect { dummy.validate_included(1, 123) }
          .to raise_error(NoMethodError, /include?/)
      end

      it 'raises error when not included' do
        expect { dummy.validate_included('5', list) }
          .to raise_error(UnknownType, /not included/)
      end

      it 'returns nil when included' do
        expect(dummy.validate_included('1', list)).to be_nil
      end
    end
  end
end
