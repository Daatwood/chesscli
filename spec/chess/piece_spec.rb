# frozen_string_literal: true

require 'spec_helper'

module Chess
  describe Piece do
    subject { Piece }

    context '.descendants' do
      it 'returns an array' do
        expect(subject.descendants).to be_an Array
      end

      it 'contains only subclasses' do
        expect(subject.descendants).to all be < subject
      end

      it 'returns the same object each call' do
        expect(subject.descendants).to equal(subject.descendants)
      end
    end
    context '.types' do
      it 'returns an array' do
        expect(subject.types).to be_an Array
      end

      it 'contains only strings' do
        expect(subject.types).to all be_a String
      end

      it 'returns the same object each call' do
        expect(subject.types).to equal(subject.types)
      end
    end

    context '.from_string' do
      describe 'expects an argument' do
        it 'be a string' do
          expect { subject.from_string(123) }.to validate_class_as String
        end

        it 'value of a valid type' do
          expect { subject.from_string('123') }
            .to validate_included_in subject.types
        end
      end

      describe 'correct agruments' do
        let(:type) { subject.types.sample }

        it 'a type of piece' do
          expect(subject.from_string(type)).to be_kind_of Piece
        end
        it 'class name matches string' do
          expect(subject.from_string(type).class.name).to match(/#{type}/i)
        end
      end
    end

    context '.available_moves' do
      subject { Piece.new }

      it 'expects a string' do
        expect { subject.available_moves(123) }.to validate_class_as String
      end

      it 'ordered by number then letter' do
        allow(Movement).to receive(:project).and_return(%w[f9 f1 a4 a1 d3])
        expect(subject.available_moves('a1'))
          .to contain_exactly('a1', 'f1', 'd3', 'a4', 'f9')
      end
    end
  end
end
