# Replace all numbers in a string with NUMBER string. Example: “abc 123 def 345 6” => ”abc NUMBER def NUMBER NUMBER”

def replacer(string)
  puts string.gsub(/\d+/, "NUMBER")
end

if ARGV.empty?
  puts "Usage: ruby #{$PROGRAM_NAME} <string>"
  exit 1
end

replacer(ARGV[0])