# Ruby Chess

Determine possible locations of a chess piece can move to on a chessboard, assuming all positions are available. 

## Getting Started

Clone the repository

### Prerequisites

Developed on Ruby 2.4

*Should work on earlier versions*

### Run it!

Possible pieces: Queen, Rook, Knight, Bishop, King

_sorry no pawn yet_

```
$ ruby chesscli.rb --piece PIECE --position POSITION
```

With `--help` option provides this friendly output

```
Usage: ruby ./chesscli.rb [options]
Specific options:
    -p, --piece PIECE                Type of chess piece. (rook, queen, knight, king, bishop)
    -l, --position POSITION          Alphanumeric position on the board. Example: d3
    -h, --help                       Show this message
```

### Example

```
$ ruby ./chesscli.rb -p knight -l b6
```

Outputs

```
a4, c4, d5, d7, a8, c8
```

## Running Tests

Make sure RSpec is installed run

```
$ bundle install
```

Run the tests

```
$ bundle exec rspec
```