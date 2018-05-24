# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chess::Movement do
  subject { described_class }

  let(:file_rank) { Chess::FileRank.from_string('a1') }
  let(:ray)       { { ray: [[0, 1]] }          }
  let(:offset)    { { offset: [[1, 1]] }       }

  describe '.types' do
    subject(:types) { described_class.types }

    it 'returns as array' do
      is_expected.to be_an Array
    end

    it 'contains only symbols' do
      is_expected.to all be_a Symbol
    end

    it 'returns the same object each call' do
      is_expected.to equal(described_class.types)
    end
  end

  describe '.move_as_offset' do
    let(:in_bound_offset) { described_class.move_as_offset(file_rank, 1, 1) }
    let(:out_bound_offset) do
      described_class.move_as_offset(file_rank, -999, -999)
    end

    it 'returns a file rank object' do
      expect(in_bound_offset).to be_kind_of Chess::FileRank
    end

    it 'off board location as nil' do
      expect(out_bound_offset).to be_nil
    end
  end

  describe '.move_as_ray' do
    subject(:move_as_ray) { described_class.method(:move_as_ray) }

    let(:in_bound_ray) { [1, 1] }
    let(:out_bound_ray) { [-999, -999] }
    let(:nowhere_ray) { [0, 0] }

    it 'return an array' do
      expect(move_as_ray[file_rank, *in_bound_ray]).to be_kind_of Array
    end

    it 'contain FileRank types' do
      expect(move_as_ray[file_rank, *in_bound_ray])
        .to all be_kind_of Chess::FileRank
    end

    it 'empty when out of bounds' do
      expect(move_as_ray[file_rank, *out_bound_ray]).to be_empty
    end

    it 'handles indexes when both zero' do
      expect(move_as_ray[file_rank, *nowhere_ray].count).to be 1
    end
  end

  describe '.project' do
    subject(:project) { described_class.method(:project) }

    context 'with wrong arguments' do
      it 'invalid movement raise an incorrect type' do
        expect { project[file_rank, nil] }.to ensure_class_as(Hash)
      end

      it 'invalid position raise an incorrect type' do
        expect { project[nil, offset] }.to ensure_class_as(Chess::FileRank)
      end
    end

    context 'with correct arguments' do
      let(:ray) { { ray: [[0, 1]] } }
      let(:not_a_move)   { { not_a_move: [0, 0] } }
      let(:offboard) { { offset: [[-100, -100]] } }

      it 'call a movement key' do
        expect(described_class).to receive(:move_as_ray)
        project[file_rank, ray]
      end

      it 'returns an array' do
        expect(project[file_rank, ray]).to be_an Array
      end

      it 'contains no nils' do
        expect(project[file_rank, offboard]).not_to include nil
      end

      it { expect { project[file_rank, not_a_move] }.to ensure_included }
    end
  end
end
