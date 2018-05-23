# frozen_string_literal: true

module Chess
  shared_examples 'a chess piece' do
    it 'inherits chess piece' do
      is_expected.to be_kind_of Piece
    end

    describe '.movement_set' do
      it 'returns a hash' do
        expect(subject.movement_set).to be_a Hash
      end
    end

    describe '.available_moves' do
      it 'requires an argument' do
        expect { subject.available_moves }.to raise_error(/given 0, expected 1/)
      end

      it 'returns an array' do
        expect(subject.available_moves('a1')).to be_an Array
      end

      it 'contains only strings' do
        expect(subject.available_moves('a1')).to all be_a String
      end
    end
  end
end
