# Ruby Chess

Determine possible positions a chess piece can move to on a chessboard, assuming all positions are available. 

## Getting Started

Clone the repository
```
$ git clone https://github.com/Daatwood/chesscli.git
```

### Prerequisites

Developed on Ruby 2.4

*Should work on earlier versions*

### Run it!

```
$ ruby chesscli.rb --piece PIECE --position POSITION
```

With `--help` option to provide helpful tip below

```
Usage: ruby ./chess_cli.rb [options]
Specific options:
    -p, --piece PIECE                Type of chess piece. (rook, queen, knight, king, bishop)
    -l, --position POSITION          Alphanumeric position on the board. Example: d3
    -h, --help                       Show this message
```

### Example

`$ ruby ./chess_cli.rb -p knight -l b6` Outputs: `a4, c4, d5, d7, a8, c8`

## Running Tests

Make sure RSpec is installed run

```
$ bundle install
```

Run the tests

```
$ bundle exec rspec
```
