# Livestorm Game

A little game in Ruby made for the Livestorm Back-End Hiring Test.
<br>
In this game, you should surivive to 10 rooms and defeat Cthulhu the destructor. 

## Installation

First of all clone the project. 
<br>
Then in the <b>game.rb</b> file, change the following line by you're local game path.

```bash
Dir["/var/www/livestorm_game/lib/*.rb"]
```

To launch the game, run the following command and have fun :) 
```bash
ruby game.rb
```

## Gems Uses
- rspec

## Testing
Install rspec
```bash
bundle install
```

And run
```bash
rspec specs/game_spec.rb
```

## Author 
Jérémy Pestelard

