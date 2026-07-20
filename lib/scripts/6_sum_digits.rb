# Write a script in Ruby that takes a positive number as an input.
# The program should take every single digit of this number, and sum them until only a 1 digit number is left.
# Example input: 31337 Output: 8, because 3+1+3+3+7=17 and 1+7=8.

def sum_digits(num)
  num = num.to_i
  return puts "Must be greater than 0" unless num > 0

  while num > 9
    num = num.digits.sum
  end

  puts num
end

sum_digits(ARGV[0])
