# frozen_string_literal: true

require 'spec_helper'

module Chess
  describe FileRank do
    subject { FileRank }

    let(:valid_format)   { 'a1'                                     }
    let(:invalid_format) { valid_format.reverse                     }
    let(:instance)       { subject.from_string(valid_format.upcase) }

    it 'privatizes new' do
      expect { subject.public_send(:new) }
        .to raise_error(NoMethodError, /private/)
    end

    describe 'RANK_RANGE' do
      it 'is defined' do
        is_expected.to have_constant(:RANK_RANGE)
      end
    end

    describe 'FILE_RANGE' do
      it 'is defined' do
        is_expected.to have_constant(:FILE_RANGE)
      end
    end

    describe '.files' do
      it 'same object each call' do
        expect(subject.files).to equal(subject.files)
      end

      it 'contains only symbols' do
        expect(subject.files).to all be_kind_of Symbol
      end
    end

    describe '.ranks' do
      it 'same object each call' do
        expect(subject.ranks).to equal(subject.ranks)
      end

      it 'contains only integers' do
        expect(subject.ranks).to all be_kind_of Integer
      end
    end

    describe '.from_string' do
      let(:oob_position) { "a#{subject.ranks.size + 1}" }

      context 'with wrong argument' do
        it 'not a string raises argument type' do
          expect { subject.from_string(55) }.to validate_class_as String
        end

        it 'empty string raises argument type' do
          expect { subject.from_string('') }.to validate_presense
        end

        it 'a wrong format returns nil' do
          expect(subject.from_string(invalid_format)).to be_nil
        end

        it 'out of bounds raises nil' do
          expect(subject.from_string(oob_position)).to be_nil
        end
      end

      context 'with correct argument' do
        it 'returns an instance' do
          expect(subject.from_string(valid_format)).to be_kind_of subject
        end

        it 'performs new call' do
          is_expected.to receive(:new).and_return(instance)
          expect(subject.from_string(valid_format)).to be_kind_of subject
        end
      end
    end

    describe '.from_indexes' do
      let(:oob_file_index) { subject.files.size + 1 }
      let(:oob_rank_index) { subject.ranks.size + 1 }

      context 'with wrong arguments' do
        it 'out of bounds file index is nil' do
          expect(subject.from_indexes(oob_file_index, 0)).to be_nil
        end

        it 'out of bounds rank index is nil' do
          expect(subject.from_indexes(0, oob_rank_index)).to be_nil
        end
      end

      context 'with correct arguments' do
        it 'is not nil' do
          expect(subject.from_indexes(0, 0)).not_to be_nil
        end

        it 'performs new call' do
          is_expected.to receive(:new).and_return(instance)
          expect(subject.from_indexes(0, 0)).to be_kind_of subject
        end
      end
    end

    describe '.valid_position?' do
      let(:invalid_file) { 'z0' }
      let(:invalid_rank) { "a#{subject.ranks.size + 1}" }

      context 'returns false' do
        it 'with nil' do
          expect(subject.valid_position?(nil)).to be false
        end

        it 'with invalid file' do
          expect(subject.valid_position?(invalid_file)).to be false
        end

        it 'out of bounds rank' do
          expect(subject.valid_position?(invalid_rank)).to be false
        end

        it 'with incorrect type' do
          expect(subject.valid_position?(99)).to be false
        end

        it "with decimal as rank" do
          expect(subject.valid_position?("a1.2")).to be false
        end
      end

      context 'returns true' do
        it 'when in bounds' do
          expect(subject.valid_position?(valid_format)).to be true
        end

        it 'case insensitive' do
          expect(subject.valid_position?(valid_format.upcase)).to be true
        end
      end
    end

    describe '.valid_indexes?' do
      context 'wrong argument types' do
        it 'file to be an integer' do
          expect { subject.valid_indexes?(3.4, 0) }.to validate_class_as Integer
        end

        it 'rank to be an integer' do
          expect { subject.valid_indexes?(0, 1.2) }.to validate_class_as Integer
        end
      end

      context 'correct argument types' do
        let(:file_bound) { subject.files.size }
        let(:rank_bound) { subject.ranks.size }

        it 'file is out of range' do
          expect(subject.valid_indexes?(file_bound, 0)).to be false
        end

        it 'rank is out of range' do
          expect(subject.valid_indexes?(0, rank_bound)).to be false
        end

        it 'within bounds' do
          expect(subject.valid_indexes?(0, 0)).to be true
        end
      end
    end

    describe '#file' do
      it 'is lowercase' do
        expect(instance.file).to be :a
      end

      it 'is a symbol' do
        expect(instance.file).to be_kind_of Symbol
      end

      it 'cannot be reassigned' do
        expect(instance).not_to be_assigning(:file)
      end
    end

    describe '#rank' do
      it 'is an integer' do
        expect(instance.rank).to be_kind_of Integer
      end

      it 'cannot be reassigned' do
        expect(instance).not_to be_assigning(:rank)
      end
    end

    describe '#file_index' do
      it 'indexes files' do
        is_expected.to receive(:files).and_return(subject.files)
        expect(instance.file_index).to be 0
      end
    end

    describe '#rank_index' do
      it 'indexes ranks' do
        is_expected.to receive(:ranks).and_return(subject.ranks)
        expect(instance.rank_index).to be 0
      end
    end

    describe '#to_s' do
      it 'is a string' do
        expect(instance.to_s).to be_kind_of String
      end

      it 'is lowercase' do
        expect(instance.to_s).to eq(valid_format)
      end
    end
  end
end
