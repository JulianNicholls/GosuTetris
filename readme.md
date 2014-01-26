# Tetris using Gosu

There's not a lot to say... It's Tetris done with the Ruby
[Gosu](http://www.libgosu.org/) Library.

## Updated in this version

Added the two snake / stair shapes. I only realised that there was something 
missing because I did a crossword with the clue 'Game played with 7 pieces'
for Tetris and I thought 'Seven? I only have five, hmm...'. 
Later on, I looked at Tris on my iPhone and saw the missing pieces.

The colours are also not random any more. The 'official' colours are now used
with each piece always being the same colour.

Potential rotation is checked before performing it now.

## TODO

Rotation around a point that isn't the top-left corner for some rotations
for some shapes.

## Controls

Use the left and right arrows to move the shapes left and right.

The up arrow rotates the piece.

The down arrow speeds the shape downward.

R   Restarts

P   Pauses

Esc Exits
