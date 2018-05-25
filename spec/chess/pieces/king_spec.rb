# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chess::King do
  subject(:piece) { described_class.new }

  let(:position)       { 'd4' }
  let(:expected_moves) { %w[c3 c4 c5 d3 d5 e3 e4 e5] }

  it_behaves_like 'a chess piece'

  describe '#available_moves' do
    it 'has immediate positions' do
      expect(piece.available_moves(position)).to match_array(expected_moves)
    end
  end
end
