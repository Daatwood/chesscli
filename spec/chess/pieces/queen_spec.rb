# frozen_string_literal: true

require 'spec_helper'

module Chess
  describe Queen do
    let(:position) { 'd4' }
    let(:expected_moves) do
      %w[a1 b2 c3 e5 f6 g7 h8 a7 b6 c5 e3 f2 g1] +
        %w[d1 d2 d3 d5 d6 d7 d8 a4 b4 c4 e4 f4 g4 h4]
    end

    it_behaves_like 'a chess piece'

    describe '#available_moves' do
      it 'in all directions' do
        expect(subject.available_moves(position)).to match_array(expected_moves)
      end
    end
  end
end
