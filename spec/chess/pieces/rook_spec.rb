# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chess::Rook do
  subject(:piece) { described_class.new }

  let(:position)       { 'd4'                                          }
  let(:expected_moves) { %w[d1 d2 d3 d5 d6 d7 d8 a4 b4 c4 e4 f4 g4 h4] }

  it_behaves_like 'a chess piece'

  describe '#available_moves' do
    it 'in all vertical and horizontal positions' do
      expect(piece.available_moves(position)).to match_array(expected_moves)
    end
  end
end
