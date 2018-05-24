# frozen_string_literal: true

RSpec.shared_examples 'a chess piece' do
  subject(:piece) { described_class.new }

  it 'inherits chess piece' do
    is_expected.to be_kind_of Chess::Piece
  end

  describe '.movement_set' do
    it 'returns a hash' do
      expect(piece.movement_set).to be_a Hash
    end
  end

  describe '.available_moves' do
    it 'requires an argument' do
      expect { piece.available_moves }.to raise_error(/given 0, expected 1/)
    end

    it 'returns an array' do
      expect(piece.available_moves('a1')).to be_an Array
    end

    it 'contains only strings' do
      expect(piece.available_moves('a1')).to all be_a String
    end
  end
end
