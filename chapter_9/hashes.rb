def know_the_abbreviation
  # Hashes remember the insertion order of their keys. Insertion order
  # isn’t always terribly important; one of the merits of a hash is
  # that it provides quick lookup in better-than-linear time
  state_hash = {"Connecticut" => "CT",
                "Delaware" => "DE",
                "New Jersey" => "NJ",
                "Virginia" => "VA"}
  print "Enter the name of a state: "
  state = gets.chomp
  abbr = state_hash[state]
  puts "The abbreviation is #{abbr}."
end

# 4 ways to create a hash:
# - With the literal constructor (curly braces)
# - With the Hash.new method
# - With the Hash.[] method (a square-bracket class method of Hash)
# - With the top-level method whose name is Hash

p this_is_a_hash = {} # {}
p this_is_a_hash = Hash["Connecticut", "CT", "Delaware", "DE"] # {"Connecticut"=>"CT", "Delaware"=>"DE"}
p this_is_a_hash = Hash[[[1, 2], [3, 4], [5, 6]]] # {1=>2, 3=>4, 5=>6}


state_hash = {"Connecticut" => "CT",
              "Delaware" => "DE",
              "New Jersey" => "NJ",
              "Virginia" => "VA"}
# To add a state to state_hash, do this,
state_hash["New York"] = "NY"
# which is the sugared version of this:
state_hash.[]=("New York", "NY")
# You can also use the synonymous method store for this operation. store takes two arguments (a key and a value):
state_hash.store("New York", "NY")
p state_hash # {"Connecticut"=>"CT", "Delaware"=>"DE", "New Jersey"=>"NJ", "Virginia"=>"VA", "New York"=>"NY"}

# Using a hash key is much like indexing an array—except that the
# index (the key) can be anything, whereas in an array, it’s always an integer.
h = Hash.new
h["a"] = 1
h["a"] = 2
p h # {"a"=>2}
puts h["a"] # 2


p state_hash.fetch("Nebraska", "Unknown state") # it retrieves "Unknown state"

state_hash = {"New Jersey" => "NJ",
              "Connecticut" => "CT",
              "Delaware" => "DE"}
# You can also retrieve values for multiple keys in one operation, with values_at
two_states = state_hash.values_at("New Jersey", "Delaware")
p two_states # ["NJ", "DE"]
begin
  # fetch_values behaves similarly, but it raises a KeyError if the requested key isn’t found
  state_hash.fetch_values("salted")
rescue => e
  puts "You got the expected error: #{e.message}" # You got the expected error: key not found: "salted"
end

# To create a default behavior, pass a block to fetch or fetch_values.
# Rather than raising an error, the unknown key will be appended to the resulting array

greg = state_hash.fetch_values("New Jersey", "WYOMING") do |key|
  key.capitalize
end
p greg # ["NJ", "Wyoming"]

# Like arrays, hashes can be nested within other hashes.
# This is a powerful way to store collections of data and is used frequently.
p nested_hash = {foo: {bar: "baz"}} # {:foo=>{:bar=>"baz"}}
p contacts = {john: {
    phone: "555-1234",
    email: "john@example.com"},
              eric: {
                  phone: "555-1235",
                  email: "eric@example.com"}} # {:john=>{:phone=>"555-1234", :email=>"john@example.com"}, :eric=>{:phone=>"555-1235", :email=>"eric@example.com"}}

# The dig method makes such collections more easily accessible. Hash#dig takes one or more symbols as arguments
p contacts.dig(:eric, :email) # "eric@example.com"

puts "#########"

p h = Hash.new { |hash, key| hash[key] = 0 } # {}
p h["jafar"]
p h["iago"]
p h["aladdin"] = "jasmine"
p h # {"jafar"=>0, "iago"=>0, "aladdin"=>"jasmine"}

h1 = {first: "Joe",
      last: "Leo",
      suffix: "III"}
h2 = {suffix: "Jr."}
# The destructive operation is performed with the update method.
# Entries in the first hash are overwritten permanently if the second hash has a corresponding key
h1.update(h2)
puts h1[:suffix] # Jr.
p h1 # {:first=>"Joe", :last=>"Leo", :suffix=>"Jr."}


h1 = {first: "Joe",
      last: "Leo",
      suffix: "III"}
h2 = {suffix: "Jr."}
# To perform nondestructive combining of two hashes, use the merge method, which gives you a third hash and leaves the original unchanged
h3 = h1.merge(h2)
p h1[:suffix] # "III"

puts "#########"

p h = Hash[1, 2, 3, 4, 5, 6] # {1=>2, 3=>4, 5=>6}
p h.select { |k, v| k > 1 } # {3=>4, 5=>6}
p h.reject { |k, v| k > 1 } # {1=>2}
p h # {1=>2, 3=>4, 5=>6}
# Be careful when you invert hashes. Because hash keys are unique, but values aren’t,
# when you turn duplicate values into keys, one of the pairs is discarded
p h.invert # {2=>1, 4=>3, 6=>5}
p h # {1=>2, 3=>4, 5=>6}
h = {1 => "one", 2 => "two"}.replace({10 => "ten", 20 => "twenty"})
p h # {10=>"ten", 20=>"twenty"}

puts "#########"

# Common hash query methods and their meanings
# - h.has_key?(1)	True if h has the key 1
# - h.include?(1)	Synonym for has_key?
# - h.key?(1)	Synonym for has_key?
# - h.member?(1)	Synonym for has_key?
# - h.has_value?("three")	True if any value in h is "three"
# - h.value?("three")	Synonym for has_value?
# - h.empty?	True if h has no key/value pairs
# - h.size	Number of key/value pairs in h

class City
  attr_accessor :name, :state, :population
end

def add_to_city_database(name, info)
  c = City.new
  c.name = name
  c.state = info[:state]
  c.population = info[:population]
  p c # #<City:0x00007fc6048de790 @name="New York City", @state="New York", @population=7000000>
end

add_to_city_database("New York City",
                     state: "New York",
                     population: 7000000,
                     nickname: "Big Apple")

puts "#########"

def m(a:, b:)
  p a, b
end

# Using named arguments saves you the trouble of “unwrapping” hashes in your methods.
# Here’s a barebones example that shows the most basic version of named arguments
p m(b: 2, a: 1) # [1, 2]
# p m(1, 2) # wrong number of arguments (given 2, expected 0; required keywords: a, b) (ArgumentError)

def m(x, y, *z, a: 1, b:, **c, &block)
  p x, y, z, a, b, c
end

p m(1, 2, 3, 4, 5, b: 10, p: 20, q: 30) # [1, 2, [3, 4, 5], 1, 10, {:p=>20, :q=>30}]
