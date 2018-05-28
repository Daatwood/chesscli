# frozen_string_literal: true

require_relative '../chess_cli'

RSpec.describe ChessCli do
  it 'when missing piece argument' do
    expect { described_class.execute }
      .to raise_error(SystemExit, /Missing required argument PIECE/)
  end

  it 'when missing position argument' do
    ARGV << '-p' << 'king'
    expect { described_class.execute }
      .to raise_error(SystemExit, /Missing required argument POSITION/)
  end

  it 'with invalid piece argument' do
    ARGV << '-p' << 'kong' << '-l' << 'd3'
    expect { described_class.execute }
      .to raise_error(SystemExit, /not a valid chess piece/)
  end

  it 'with invalid position argument' do
    ARGV << '-p' << 'king' << '-l' << 'd3.5'
    expect { described_class.execute }
      .to raise_error(SystemExit, /not a valid position/)
  end

  it 'prints with valid arguments' do
    ARGV << '-p' << 'king' << '-l' << 'd3'
    expect { described_class.execute }.to terminate.with_code(0)
  end
end
