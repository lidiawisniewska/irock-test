# In Ruby, write a script that takes the numbers from 1 to 100, and for each number outputs:
# “Fizz” if the number is a multiple of 3
# “Buzz” if the number is a multiple of 5
# “FizzBuzz” if the number is a multiple of both 3 and 5
# Output the number itself if it is not a multiple of 3 or 5


arr = (1..100)
def fizz_buzz(arr)
  arr.each do |num|
    if num % 3 == 0 && num % 5 == 0
      puts "FizzBuzz"
    elsif num % 3 == 0
      puts "Fizz"
    elsif num % 5 == 0
      puts "Buzz"
    else
      puts num
    end
  end
end

fizz_buzz(arr)
