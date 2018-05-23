# frozen_string_literal: true

require 'spec_helper'

module Chess
  describe Movement do
    subject { Movement }

    let(:file_rank) { FileRank.from_string('a1') }
    let(:ray)       { { ray: [[0, 1]] }          }
    let(:offset)    { { offset: [[1, 1]] }       }

    describe '.types' do
      it 'returns as array' do
        expect(subject.types).to be_an Array
      end

      it 'contains only symbols' do
        expect(subject.types).to all be_a Symbol
      end

      it 'returns the same object each call' do
        # TODO: custom `be_the_same` matcher
        expect(subject.types).to equal(subject.types)
      end
    end

    describe '.move_as_offset' do
      it 'returns a FileRank' do
        expect(subject.move_as_offset(file_rank, 1, 1)).to be_kind_of FileRank
      end

      it 'off board location as nil' do
        expect(subject.move_as_offset(file_rank, -100, -100)).to be_nil
      end
    end

    describe '.move_as_ray' do
      it 'return an array' do
        expect(subject.move_as_ray(file_rank, 1, 1)).to be_kind_of Array
      end

      it 'contain FileRank types' do
        expect(subject.move_as_ray(file_rank, 1, 1)).to all be_kind_of FileRank
      end

      it 'empty when out of bounds' do
        expect(subject.move_as_ray(file_rank, -100, -100)).to be_empty
      end
    end

    describe '.project' do
      context 'with wrong arguments' do
        it 'invalid movement raise an incorrect type' do
          expect { subject.project(file_rank, nil) }.to validate_class_as(Hash)
        end

        it 'invalid position raise an incorrect type' do
          expect { subject.project(nil, offset) }.to validate_class_as(FileRank)
        end
      end

      context 'with correct arguments' do
        let(:ray_and_offset) { { ray: [[0, 1]], offset: [[1, 0]] } }
        let(:not_a_move)   { { not_a_move: [0, 0] }  }
        let(:offboard_ray) { { ray: [[-100, -100]] } }

        it 'calls multiple movement keys' do
          is_expected.to receive(:move_as_offset).and_return(file_rank)
          is_expected.to receive(:move_as_ray).and_return([file_rank])
          subject.project(file_rank, ray_and_offset)
        end

        it 'contains no nils' do
          expect(subject.project(file_rank, offboard_ray)).not_to include(nil)
        end

        it 'expects valid movement key' do
          expect { subject.project(file_rank, not_a_move) }
            .to validate_included_in subject.types
        end
      end
    end
  end
end
