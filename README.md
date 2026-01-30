# Brainf**k Interpreter
In my Programming Langauges class, we're learning Racket in the first half of the semester to write languages in the second.

I figured why not do both at one? BF is about the simplest language there is in terms of syntax, and it's funny, so I wrote an interpreter for it.

## Design
I figured out that I wanted to define loops recursively, but doing that live-interpreting would have been a pain. Instead, I have a parser that turns the string into operators, then an interpreter to evaluate them.

### Loop Types
I defined the operations in a way that makes them REALLY easy to execute recursively.
- Normal operations are themselves
- A Loop operation HOLDS a list of internal operations, which may also have loops

This allows the interpreter to simply evaluate as follows:
- If the operator is normal, use it's function
- If the operator is a loop, run the loop evaluator

The loop evaluator:
- If the current cell is 0, this loop is done, return to the operation list above it
- Otherwise, just run the normal interpreter on the loop contents again

> [!NOTE]
> The Parser is pretty simple as well, it just creates a recursive stack for building the loop operators

### Tape
I was initially trying to do a vector thing with a current index tracker, but realized there's a much easier way:
This is the imperative equivalent:
```cpp
struct tape {
    vector<int> left;
    int current;
    vector<int> right;
}
```
With this, all we need to do when moving is to add current as the top value to the opposite side, then pop from the new side to get the new current. 

It also makes it much easier to provide the "infinite tape" illusion.

If we do a > operator (move right), and the right side of the tape is empty, we can just set curr to 0 and keep the right side empty. From the programs perspective, it moved, but we had to do nothing but add to the left side
