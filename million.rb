# Renamed attribute to "value" as this will sometimes be a Fixnum, and sometimes a string
def get_unit_value(value)
  in_words = {0 => "",
              1 => "one",
              2 => "two",
              3 => "three",
              4 => "four",
              5 => "five",
              6 => "six",
              7 => "seven",
              8 => "eight",
              9 => "nine"}
  if value.class == Fixnum
    return in_words[value]
  # For the teens exception, I'll sometime send a string here to convert back to a number
  elsif value.class == String
    return in_words.key(value)
  end
end

def get_tens_value(number)
  in_words = {0 => "",
              2 => "twenty",
              3 => "thirty",
              4 => "forty",
              5 => "fifty",
              6 => "sixty",
              7 => "seventy",
              8 => "eighty",
              9 => "ninety"}
  return in_words[number]
end

def get_teen_value(number)
  in_words = {10 => "ten",
              11 => "eleven",
              12 => "twelve",
              13 => "thirteen",
              14 => "fourteen",
              15 => "fifteen",
              16 => "sixteen",
              17 => "seventeen",
              18 => "eighteen",
              19 => "nineteen"}
  return in_words[number]
end

def find_length(number)
  strung = number.to_s
  length = strung.length
end

def get_units_words(position, character)
  if position > 1
    # If we're in a thousand's position, add the word "thousand"
    if position % 6 == 4
      @word << "thousand"
    # If we're in the million's position, add the word "million"
    elsif position % 6 == 1
      # If there are zero units of 1000 (i.e. one million)
      if @word[-1] == "" && @word[-2] == "" && @word[-3] == ""
        # we need to remove the word "thousand"
        @word.pop(4)
      end
      @word << "million"
    end
  end
  # Add the unit value of the character
  @word << get_unit_value(character)
end

def get_tens_words(character)
  # If we need to convert the previously collected unit value to a teen value
  if character == 1
    # Convert the previously gotten unit word back to a number
    unit = get_unit_value(@word.pop)
    teen = 10 + unit
    @word << get_teen_value(teen)
  else
    @word << get_tens_value(character)
  end
end

def get_hundreds_words(position, character)
  # Unless it's a whole hundred, it needs the "and" word to describe the 10s and/or units.
  unless @word[-1] == "" && @word[-2] == ""
    @word << "and"
  end
  if character == 0
    @word << ""
  else
    @word << "hundred"
    @word << get_unit_value(character)
  end
end

# Reverses the string back to correct order, removes any empty words and joins
def clean_up
  # Reverse string back to correct order
  @word = @word.reverse
  # Filter out any "empty" words
  @word = @word.select { |word| word.length != 0 }
  # print all words with a space between each
  puts @word.join(" ")
end

def wordify(number)
  @word = []
  length = find_length(number)
  # Reverse the number as a string so we can work from the units end
  strung = number.to_s.reverse
  (1..length).each do |position|
    character = strung[position - 1].to_i
    # If position is in the units (incl. thousands, millions) place...
    if position % 3 == 1
      get_units_words(position, character)
    # If position is in the tens position...
    elsif position % 3 == 2
      get_tens_words(character)
    # If position is in the hundreds postion...
    elsif position % 3 == 0
      get_hundreds_words(position, character)
    end
  end
  clean_up
end

(1..1000000).each do |number|
  print number, " = ", wordify(number)
end

# IF LENGTH = 1, result = number to @words
# IF LENGTH = 2, result = tens value followed by re-use LENGTH = 1
# EXCEPTION REQUIRED FOR TEENS - will already have the unit value, it will need to be destroyed and reformed

# IF LENGTH = 3, result = number to @words followed by "hundred and" and re-use LEGNTH = 2
# IF LENGTH = 4, result = number to @words, followed by "thousand" and re-use LENGTH = 3

# IF LENGTH = 5, result = re-use LENGTH = 2 and LENGTH = 4
# IF LENGTH = 6, result = re-use LENGTH = 3 and LENGTH = 4

# IF LENGTH = 7, result = number to @words, followed by "million" and LENGTH = 6

# Following these rules, I could actually cope with any positive integer, as long as you don't mind
# re-using the million pattern over and over
# e.g. 1,000,000,000,000 would be expressed as 1 million million.