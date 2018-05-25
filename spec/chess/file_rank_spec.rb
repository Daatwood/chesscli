# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chess::FileRank do
  subject(:instance) { described_class.from_string(valid_format) }

  let(:valid_format) { 'a1' }

  let(:files_size)   { described_class.files.size }
  let(:ranks_size)   { described_class.ranks.size }

  describe 'FILE_RANGE' do
    it { expect(described_class).to have_constant :FILE_RANGE }
  end

  describe 'RANK_RANGE' do
    it { expect(described_class).to have_constant :RANK_RANGE }
  end

  describe '.new' do
    it 'is private' do
      expect { described_class.public_send(:new) }
        .to raise_error(NoMethodError, /private/)
    end
  end

  describe '.files' do
    subject(:files) { described_class.files }

    it 'same object each call' do
      is_expected.to equal(described_class.files)
    end

    it 'contains only symbols' do
      is_expected.to all be_kind_of Symbol
    end
  end

  describe '.ranks' do
    subject(:ranks) { described_class.ranks }

    it 'same object each call' do
      is_expected.to equal(described_class.ranks)
    end

    it 'contains only integers' do
      is_expected.to all be_kind_of Integer
    end
  end

  describe '.from_string' do
    subject(:from_string) { described_class.method(:from_string) }

    context 'with wrong argument type' do
      it { expect { from_string[55] }.to ensure_class_as String }

      it { expect { from_string[''] }.to ensure_presence }
    end

    context 'with correct argument type' do
      it 'calls valid position' do
        expect(described_class).to receive(:valid_position?)
        from_string[valid_format]
      end

      it 'invalid position returns nil' do
        expect(from_string['9a']).to be_nil
      end

      it 'returns an instance' do
        expect(from_string[valid_format]).to be_kind_of described_class
      end

      it 'performs new call' do
        expect(described_class).to receive(:new)
        from_string[valid_format]
      end

      it 'sets file to lowercase' do
        expect(from_string[valid_format].file).to match(/[a-z]/)
      end

      it 'removes leading and trailing whitespace' do
        expect(from_string['   a1   '].to_s).to eq 'a1'
      end
    end
  end

  describe '.from_indexes' do
    subject(:from_indexes) { described_class.method(:from_indexes) }

    context 'with wrong argument types' do
      it { expect { from_indexes['0', '0'] }.to ensure_class_as Integer }
    end

    context 'with correct argument types' do
      it 'calls valid indexes' do
        expect(described_class).to receive(:valid_indexes?)
        from_indexes[0, 0]
      end

      it 'out of bounds is returns nil' do
        expect(from_indexes[files_size, ranks_size]).to be_nil
      end

      it 'returns an instance' do
        expect(from_indexes[0, 0]).to be_kind_of described_class
      end

      it 'performs new call' do
        expect(described_class).to receive(:new)
        from_indexes[0, 0]
      end
    end
  end

  describe '.valid_position?' do
    subject(:position) { described_class.method(:valid_position?) }

    context 'with wrong argument types' do
      it 'with empty string' do
        expect(position['']).to be false
      end

      it 'with a number' do
        expect(position[11]).to be false
      end
    end

    context 'when invalid' do
      it 'out of bounds file' do
        expect(position['z1']).to be false
      end
      it 'out of bounds rank' do
        expect(position["a#{ranks_size + 1}"]).to be false
      end
      it 'zero rank' do
        expect(position['a0']).to be false
      end
      it 'with decimal' do
        expect(position['d1.2']).to be false
      end
      it 'is a number' do
        expect(position[99]).to be false
      end

      it 'wrong format' do
        expect(position['1a']).to be false
      end
    end

    context 'when valid' do
      it 'lowest position' do
        expect(position['a1']).to be true
      end

      it 'highest position' do
        expect(position["H#{ranks_size}"]).to be true
      end

      it 'in all caps' do
        expect(position['A1']).to be true
      end
    end
  end

  describe '.valid_indexes?' do
    subject(:indexes) { described_class.method(:valid_indexes?) }

    context 'with wrong argument types' do
      it 'with decimal indexes' do
        expect { indexes[3.4, 0] }.to ensure_class_as Integer
      end

      it 'with strings' do
        expect { indexes['0', '1'] }.to ensure_class_as Integer
      end
    end

    context 'when invalid' do
      it 'out of bounds file index' do
        expect(indexes[files_size, 0]).to be false
      end
      it 'out of bounds rank index' do
        expect(indexes[0, ranks_size]).to be false
      end
      it 'negative file index' do
        expect(indexes[-1, 0]).to be false
      end
      it 'negative rank index' do
        expect(indexes[0, -1]).to be false
      end
    end

    context 'when valid' do
      it 'upper bound file index' do
        expect(indexes[files_size - 1, 0]).to be true
      end
      it 'upper bound rank index' do
        expect(indexes[0, ranks_size - 1]).to be true
      end

      it 'inside index bounds' do
        expect(indexes[rand(files_size), rand(ranks_size)]).to be true
      end
      it 'zero indexes' do
        expect(indexes[0, 0]).to be true
      end
    end
  end

  describe '#file' do
    it { expect(instance.file).to be_kind_of Symbol }
    it { expect(instance).not_to reassign :file }
  end

  describe '#rank' do
    it { expect(instance.rank).to be_kind_of Integer }
    it { expect(instance).not_to reassign :rank }
  end

  describe '#file_index' do
    it 'returns the correct index' do
      expect(instance.file_index)
        .to eq described_class.files.index(instance.file)
    end
  end

  describe '#rank_index' do
    it 'returns the correct index' do
      expect(instance.rank_index)
        .to eq described_class.ranks.index(instance.rank)
    end
  end

  describe '#to_s' do
    it 'is a string' do
      expect(instance.to_s).to be_kind_of String
    end

    it 'is lowercase' do
      expect(instance.to_s).to eq valid_format
    end
  end

  describe '#==' do
    let(:other) { described_class.from_string('a1') }

    it 'compares string value' do
      is_expected.to be == other
    end
  end
end
