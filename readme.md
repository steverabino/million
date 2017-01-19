## The Million Challenge

### Objective

At a previous workplace, I was told of a challenge that they sometimes set
new Ruby developer candidates. As I was contemplating moving into this space in
future, I had a go.

The challenge is basically this: Using Ruby, write out in words the numbers from
one to one million in words (without punctuation), for example `18,992` would
be:

"eighteen thousand nine hundred and ninety two"

### Approach

Firstly, I could see that there are already Ruby Gems devoted to converting
numbers to words, so would point this out in any interview type situation.
However, I wanted to challenge myself to do it purely in Ruby.

I also took the approach of not limiting it to one million, as having the
arbitrary limit made more obvious, though less technically sound solutions
available

My approach was to reverse any number given, and work through it starting from
the units value through, as this is similar to how the numbering system
generally works. The words I created from the number are added to an array for
storage (this array holds a word representation of the digits which is also in
reverse until the end of the code.

I used the modulo operator of the position of any number against 3 or 6 to work
out how each number should be treated, whether as a "unit", a "tens value", or a
"hundreds value"; beyond that, the numbering system repeats over, using other
words (e.g. "thousand", "million") to indicate scale.

#### Units

Units were straight-forward and could be converted directly to a string. The
only exception being 0, which should be represented by no words (`10`,
`130`, `20,222` all have no words to represent the zero in the units/thousands
columns)

#### Tens

Tens were a little more taxing. To start, most can be converted directly to a
string ("twenty", "thirty", "forty").

Zeros can, as in units, be represented by no words (`104`, `2,902` have no
words representing the zero in the tens column)

However, numbers between 10 and 19 were a challenge. In these cases, I would
need to alter the number already given to me by the preceding "Units" process.
In these cases (if the tens digit was 1), I "popped" the existing unit word from
my array of words, converted it back to a number, added 10 to it, and looked
up the new "teen" word up in another hash.

#### Hundreds

Mostly, hundreds were similar to units, just with the words "hundred and"
appended to the word (prepended in my case, as I'm still working in reverse!).

The one other edge case that nearly caught me out is that if there are no tens
or units within the hundred, it should not included the word "and" (`100`,
`700,300` have no "and" word represented in their corresponding words). For
this, I checked if the last two words used were empty strings (which would be
true only if they were both originally 0 values).

#### Thousands and Millions

These are treated by the same code as Units (with the addition of the words
"thousand" and "million"), and a small edge case that needed to be added to
detect whether there were zero thousand. If the code is evaluating a "million"
value, and detects the last three words are empty strings, and removes the
"thousand" string added.

It seemed easier to add the "thousand" word indiscriminatley, and remove it
later if I detected there were no thousands when I got to evaluating the
"millions" figure, as a 0 in the thousand column does not necessarily mean the
"thousand" word should not be used (`10,000` and `700,328` both use the
word "thousand" in their representations despite having 0s in the thousands
position).

#### Clean Up

To complete the task for a single number, the words in the array are reversed
and any empty strings removed before all the words are joined using a single
space.

### Results

The code can be run by running `ruby million.rb` from the command line.

![Example output of code](/example-output.png)

If you want to test a particular number, you can replace the code:

```
(1..1000000).each do |number|
  print number, " = ", wordify(number)
end
```

with the following, replacing "number" with the number you want to test

```
print number, " = ", wordify(number)
```

I'm quite happy with the results, as I believe this code goes on to work for any
positive integer, as as long as you don't mind re-using the million pattern over
and over (for example, `1,000,000,000,000` is expressed as 1 million million).