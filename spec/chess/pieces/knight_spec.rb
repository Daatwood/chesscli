# frozen_string_literal: true

require 'spec_helper'

module Chess
  describe Knight do
    let(:position)       { 'd4'                        }
    let(:expected_moves) { %w[b3 b5 c2 c6 e2 e6 f3 f5] }

    it_behaves_like 'a chess piece'

    describe '#available_moves' do
      it 'has L-shaped positions' do
        expect(subject.available_moves(position)).to match_array(expected_moves)
      end
    end
  end
end
