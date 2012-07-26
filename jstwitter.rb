require 'jumpstart_auth'

class JSTwitter
	attr_reader :client

	def initialize
		puts "Initializing"
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		
		if message.size <= 140 
			@client.update(message)
		else
			puts "Your tweet is too long!"
		end
	end

	def run
		puts "Welcome to the Laura and Nick Awesomesauce Twitter Client!"
		command = ""
		while command != "q"
			printf "enter command: "
			input =gets.chomp
			parts = input.split(" ")

			case parts[0]
			when 'q' 
				puts "Goodbye!"
				exit
			when 't'
				tweet(parts[1..-1].join(" "))
			when 'elt'
			  everyones_last_tweet
			when 'dm'
				dm(parts[1], parts[2..-1].join(" "))
			else
				puts "Sorry, I dont know how to #{input}"
			end

		end
	end

	def dm(target, message)
		screen_names = @client.followers.collect{|follower| follower.screen_name}
		if screen_names.include?(target)
			tweet("d" + " " + target + " " + message)
			puts "Trying to send #{target} this direct message:"
			puts message
		else 
			puts "You're not following this person, so you can't DM them."
		end
	end
	
	def followers_list
	  @screen_names = screen_name
  end
  
  def friends_list
    @friends_list = @client.friends.collect{|friend| friend.screen_name}
  end
  
  def spam_my_friends #or following_users
    @friends_list.each do |x|
    tweet("d" + " " + x + " " + message)
    end
  end  
    
  def spam_my_followers(message)
    @screen_names.each do |x|
    tweet("d" + " " + x + " " + message)
    end
  end
  
  def everyones_last_tweet
    friends = @client.friends
    friends.each do |friend|
      puts ""
      puts friend.status.text
      puts ""
      puts friend.status.created_at
      puts ""
      puts friend.status.source
      puts ""  # Just print a blank line to separate people
    end
  end
  

end

jst = JSTwitter.new
jst.run