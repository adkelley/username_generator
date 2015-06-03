#!/usr/bin/env ruby

# username.rb

# Goal:
    
#    * John Doe 1978 --> jdoe78
#    * John Doe 1978 --> jdoe78_1
#    * John Doe 1978 --> jdoe78_2
#    * John Doe 1978 1 --> seller-jdoe78_1
#    * John Doe 1978 2 --> manager-jdoe78_1
#    * John Doe 1978 3 --> admin-jdoe78_1

# store hashes of names to prevent name conflicts
$unique = Hash.new()

# remove all non-alpbetic chars
# including spaces, digits, punctuation
def remove_non_alpha(word)
  word.strip.downcase.gsub(/[\W\d]/, "")
end

# 1. Accept a users's first name
# return only the first character
# make it lowercase
def generate_username1(first_name)
  remove_non_alpha(first_name)[0]
end

# 2. create a binary function generate_username2 that accepts a user's first and last name
# return the first char of the first name + the last name
# make it lowercase remove leading and trailing spaces
# reject invalid input: e.g. cases like ""
# STRETCH: ensure that only alphabet characters are allowed
def generate_username2(first_name, last_name)
  if (first_name == "" || last_name == "")
    nil
  else
     generate_username1(first_name) + remove_non_alpha(last_name)
  end
end

# 3. create a function `generate_username3` that takes three arguments: first_name, last_name and birth_year
#    * combine them into one string, e.g. "smith1980"
#    * use only the last two digits of birth_year
#    * reject invalid birth_year input: e.g. cases like 80, 198, 20111
def generate_username3(first_name, last_name, birth_year)
  birth_str = birth_year.to_s
  if birth_str.length == 4
    generate_username2(first_name, last_name) + birth_year.to_s[2,3]
  else
    nil
  end
end

# 4. Privilege levels `check_privilege` --> GOAL: "seller-jdoe78", "admin-xkcd78"
#    * Create a function that allocates privileges according to the following table:
#        * 0 --> "user"
#        * 1 --> "seller"
#        * 2 --> "manager"
#        * 3 --> "admin"
#    * return a string indicating the corresponding privilege level
#    * make the privilege level 0 by default
def check_privilege(level=0)
  table = Hash[0, "user",
               1, "seller",
               2, "manager",
               3, "admin"]
  table[level]
end

#    * STRETCH: modify your function to `generate_username4` and have it create accounts that specify user privileges
#        * prefix usernames with e.g. "admin-", "seller-" --> "seller-jdoe78"
#        * However do not add any prefix for normal users.
def generate_username4(first_name, last_name, birth_year, level=0)
  privilege = check_privilege(level)
  if (privilege == "user")
    generate_username3(first_name, last_name, birth_year)
  else
    privilege + "-" + generate_username3(first_name, last_name, birth_year)
  end
end

# 5. ensure username uniqueness `generate_username5`
#    * save your usernames as you create them --> (think about how you want to store them)
#    * if a username already exists, append "_1"
#        * STRETCH: increment n: e.g.  jdoe78, jdoe78_1,  jdoe78_2, bbunny60, bbunny60_1
def generate_username5(first_name, last_name, birth_year)
  username = generate_username3(first_name, last_name, birth_year)
  if ($unique.has_key?(username))
    $unique[username] += 1
    return username + "_" + $unique[username].to_s
  else
    $unique[username] = 0
    return username
  end
end

# Get input from the user, either from
# prompts or via the command line
def main() 
  if ARGV.empty?
    puts "What is your first name?"
    first_name = gets.chomp
    puts "What is your last name?"
    last_name = gets.chomp
    puts "What is your birth year?"
    birth_year = gets.chomp
    puts generate_username5(first_name, last_name, birth_year)
  else 
    first_name = ARGV.shift
    last_name = ARGV.shift
    birth_year = ARGV.shift
    puts generate_username5(first_name, last_name, birth_year)
  end
end

main()
