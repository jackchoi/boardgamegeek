# boardgamegeek [![Build Status](https://travis-ci.org/jackchoi/boardgamegeek.svg?branch=master)](https://travis-ci.org/jackchoi/boardgamegeek) [![Code Climate](https://codeclimate.com/github/jackchoi/boardgamegeek/badges/gpa.svg)](https://codeclimate.com/github/jackchoi/boardgamegeek) [![Test Coverage](https://codeclimate.com/github/jackchoi/boardgamegeek/badges/coverage.svg)](https://codeclimate.com/github/jackchoi/boardgamegeek)

`boardgamegeek` provides a Ruby interface to retrieve data from [BGG_XML_API2](http://boardgamegeek.com/wiki/page/BGG_XML_API2). 

## Project status

The project is currently under development.

## Usage

Board Game Geek has many of their data listed under "Things". These include board games, board game expansions, video games, etc. Many of the data that can be retrieved are namespaced under their types:

```
BoardGameGeek::Thing
BoardGameGeek::BoardGame
BoardGameGeek::BoardGameExpansion
BoardGameGeek::VideoGame
```

Finding items by id:

```
# find something with an id of 70323
BoardGameGeek::Thing.find(70323)

# find a board game with id 70323
BoardGameGeek::BoardGame.find(70323)

# find a board game expansion with id 127067
BoardGameGeek::BoardGameExpansion.find(127067)
```

Search items by title:

```
# searches all Things where the name is like "Escape"
BoardGameGeek::Thing.search("Escape")

# searches all Things where the name is exactly "Twilight Imperium"
BoardGameGeek::Thing.search("Twilight Imperium", :exact => true)

# searches all board games where the name is like "King of Tokyo"
BoardGameGeek::BoardGame.search("King of Tokyo")
```

## Contributing to boardgamegeek
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Jack. See LICENSE.txt for
further details.
