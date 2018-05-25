# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chess::Piece do
  describe '.descendants' do
    subject(:descendants) { described_class.descendants }

    it 'returns an array' do
      is_expected.to be_an Array
    end

    it 'contains only subclasses' do
      is_expected.to all be < described_class
    end

    it 'returns the same object each call' do
      is_expected.to equal(described_class.descendants)
    end
  end

  describe '.types' do
    subject(:types) { described_class.types }

    it 'returns an array' do
      is_expected.to be_an Array
    end

    it 'contains only strings' do
      is_expected.to all be_a String
    end

    it 'returns the same object each call' do
      is_expected.to equal(described_class.types)
    end
  end

  describe '.from_string' do
    context 'with incorrect argument' do
      it 'be a string' do
        expect { described_class.from_string(123) }.to ensure_class_as String
      end

      it 'value of a valid type' do
        expect { described_class.from_string('kong') }.to ensure_included
      end
    end

    context 'with correct argument' do
      subject(:from_string) { described_class.from_string(type) }

      let(:type) { described_class.types.sample }

      it 'a type of piece' do
        expect(from_string).to be_kind_of described_class
      end

      it 'correct class is created' do
        expect(from_string.class.name).to match(/#{type}/i)
      end

      it 'is case insensitive' do
        expect(described_class.from_string(type.upcase)).not_to be_nil
      end

      it 'removes leading and trailing whitespace' do
        expect(described_class.from_string('   KING   ')).not_to be_nil
      end
    end
  end

  describe '.available_moves' do
    subject(:new) do
      instance_double('piece', movement_set: {},
                               available_moves: %w[f9 f1 a4 a1 d3])
    end

    it 'expects a string' do
      expect { new.available_moves(123) }.to ensure_class_as String
    end

    it 'ordered by number then letter' do
      expect(new.available_moves('a1'))
        .to contain_exactly('a1', 'f1', 'd3', 'a4', 'f9')
    end
  end
end
