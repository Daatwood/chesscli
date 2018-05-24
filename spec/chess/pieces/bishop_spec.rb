# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chess::Bishop do
  subject(:piece) { described_class.new }

  let(:position)       { 'd4'                                       }
  let(:expected_moves) { %w[a1 b2 c3 e5 f6 g7 h8 a7 b6 c5 e3 f2 g1] }

  it_behaves_like 'a chess piece'

  describe '#available_moves' do
    it 'has diagonal positions' do
      expect(piece.available_moves(position)).to match_array(expected_moves)
    end
  end
end
