def get_unit_value(number)
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
  if number.class == Fixnum
    return in_words[number]
  elsif number.class == String
    return in_words.key(number)
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

def stringify(number)
  strung = number.to_s
end

def find_length(number)
  strung = stringify(number)
  length = strung.length 
end

def wordify(number)
  word = []
  length = find_length(number)
  strung = stringify(number).reverse
  (0...length).each do |letter|
    this = strung[letter].to_i
    if letter%3 == 0
      if letter > 0
        if letter%6 == 3
          word << "thousand"
        elsif letter%6 == 0
          if word[-1] == "" && word[-2] == "" && word[-3] == ""
            word.pop(4)
          end
          word << "million"
        end
      end
      word << get_unit_value(this)
    elsif letter%3 == 1
      if this == 1
        unit = get_unit_value(word.pop)
        teen = 10 + unit
        word << get_teen_value(teen)
      else
        word << get_tens_value(this)
      end
    elsif letter%3 == 2
      unless word[-1] == "" && word[-2] == ""
        word << "and"
      end
      if this == 0
        word << ""
      else
        word << "hundred"
        word << get_unit_value(this)
      end
    end
  end
  word = word.reverse
  word.each do |i|
    unless i == ""
      print i, " "
    end
  end
  print "\n"
end

(1..1000000).each do |number|
  print number, " = "
  wordify(number)
end

# IF LENGTH = 1, result = number to words
# IF LENGTH = 2, result = tens value followed by unit value
# EXCEPTION REQUIRED FOR TEENS
# IF LENGTH = 3, result = number to words followed by "hundred and"
# IF LENGTH = 4, result = number to words, followed by "thousand,"

# So, for teen, I will have 
# for 113, I have already the three, so I will have to destroy and replace it