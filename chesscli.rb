#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/chess'

options = { piece: nil, position: nil }
OptionParser.new do |opts|
  opts.version = '1.0'
  opts.banner = "Usage: ruby #{__FILE__} [options]"
  opts.separator 'Specific options:'

  opts.on('-p', '--piece PIECE',
          "Type of chess piece. (#{Chess::Piece.types.join(', ')})") do |piece|
    options[:piece] = piece
  end
  opts.on('-l', '--position POSITION',
          'Alphanumeric position on the board. Example: d3') do |position|
    options[:position] = position
  end
  opts.on_tail('-h', '--help', 'Show this message') do
    puts opts
    exit
  end
end.parse!

options.each do |option, value|
  abort "Missing required argument #{option.upcase}." if value.nil?
end

piece = options.fetch(:piece).strip
position = options.fetch(:position).strip

unless Chess::Piece.types.include? piece.downcase
  abort "#{piece} is not a valid chess piece."
end

unless Chess::FileRank.valid_position? position
  abort "#{position} is not a valid position on a chessboard."
end

puts Chess::Piece.from_string(piece).available_moves(position).join(', ')
