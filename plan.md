# Brainfuck Interpreter
A small planning doc for how I'm going to make this interpreter

## Representations
What sort of design / structure should I use for the main parts

### Infinite Tape
#### Option 1 - Vector
I could keep a full vector / list of the tape, and just move through that

Seems like it could be difficult recursion-wise.
Would require deconstructing / recursing all the way down, then rebuilding all the way up

#### Option 2 - Zipper List
Essentially, we keep
```
List<byte> leftwards
byte curr
List<byte> rightwards
```

When moving along, if leftwards is empty and we try and move into it, thats a out of bounds failure.
If we are moving right and it's empty, then we need to keep building it rightwards 
(to give the idea of an 'infinite' tape)

I'm leaning towards this, it seems much easier to deal with in a functional language

### File
#### Option 1 - Live-Parsing
This way would deal more directly with the strings of the file

It has no upfront complexity, it's just more complex to deal with throughout

#### Option 2 - Simple Pre-Parsing
This would be going through the whole file of bytes in the first place and parsing them into 
distinct operations.

Would make things a bit easier to deal with throughout (not strings). 

Also allows easy removal of non-operator characters right from the start

#### Option 3 - Bracket-Based Pre-Parsing
This works off the idea that everything WITHIN a bracket runs linearly

This allows the type to become very recursive.

We can define an operator type that has all the operators and the 'bracket' type

The bracket type is defined as a list of operators, which means it may also contain other brackets

This would allow so that when we GET to a bracket, we can do the start check, but when we finish a bracket, it could do the end check.

With this model, how would I come out of one?

After we process a bracket, how can we come OUT of a bracket with the correct state?
