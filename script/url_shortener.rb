def run
  user = get_user
  input = get_input
  case input
  when 1
    add_url(user)
  when 2
    launch(user)
  when 3
    add_comment(user)
  when 4
  when 5
  end
end

def get_user
  puts "What's your screen name?"
  screen_name = gets.chomp
  user = User.find_by_screen_name(screen_name)
  if user == nil
    puts "No user with that screen name found, " +
    "creating new account. What's your e-mail?"
    e_mail = gets.chomp
    user = User.create(:screen_name => screen_name, :e_mail => e_mail)
  end
  user
end

def get_input
  puts "What would you like to do?"
  puts "1. Add URL"
  puts "2. Open URL"
  puts "3. Add comment"
  puts "4. Print URL stats"
  puts "5. Print user's links"
  valid_input = false
  until valid_input
    input = gets.chomp.scan(/\d/)
    valid_input = true if input.length == 1
  end
  input.to_i
end

def add_url(user)
  puts "Enter the URL you would like shortened:"
  long_url = gets.chomp
  ShortUrl.add(long_url, user)
end

def launch(user)
  puts "Enter shortened URL:"
  input_url = gets.chomp
  short_url = ShortUrl.find_by_url(input_url)
  if short_url
    long_url = LongUrl.find_by_id(short_url.long_id)
    Launchy.open(long_url.url)
    Visit.create(:user_id => user.id, :short_url_id => short_url.id)
  else
    raise 'That short url is not in the database.'
  end
end

def add_comment(user)
  puts "Which link would you like to comment on?"
  short_url = gets.chomp
end