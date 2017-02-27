require_relative 'usernames.rb'
require_relative 'member.rb'
require_relative 'authenticationtests.rb'
require 'pry'

class ChatRoom
  extend Usernames
  extend AuthenticationTests

  def initialize
    @members = {}
    @rem_names = Usernames::ALL_NAMES
    @tests = AuthenticationTests::TESTS
  end

  def each
      @members.each { |m| yield m }
  end

  def fetch_name
    @rem_names = Usernames::ALL_NAMES if @rem_names.empty?
    name = @rem_names.delete @rem_names.sample
  end

  def initiate_welcome_sequence(new_member)
    new_member.send("You're input will not display as you are typing. To alter this, see the comments in the loop of the client.rb file.")
    new_member.send("Validating...")
    new_member.auth_test = @tests.sample
    new_member.send(new_member.auth_test[:prompt])
    new_member
  end

  def add_member(ws)
    name = fetch_name
    new_member = Member.new(ws, name, standing="authenticating")
    @members[ws] = new_member
    initiate_welcome_sequence(new_member)
  end

  def send_msg(ws, msg)
    #TODO split up, should have a router and functions for each
    #TODO should I put back in the 'unknown' status to start? currently there is no use
    sender = @members[ws]
    case sender.standing
    when "good"
      complete_msg = "[#{sender.name}] - #{msg}"
      puts "#{Time.now}: #{ws.remote_ip} -- #{complete_msg}"
      #this ternary if dedicated to steven.
      @members.each_value {|member| member == sender ? member.send("*#{complete_msg}") : member.send(complete_msg)}

    when "banned"
      member.send("You were banned! You may only lurk.")

    when "authenticating"
      if sender.auth_test[:answers].include?(msg.downcase)
        #TODO this should validate them if the answer is correct and tell them what their name is
        sender.standing = "good"
        sender.send("Correct - your text will now be printed to the chat")
      else
        sender.send("Try again")
      end
    end
  end

  def remove_member(ws)
    @members.delete(ws)
  end

  def get_member_by_ws(ws)
    @members[ws]
  end

  def is_integer?(str)
    Integer(msg) rescue False
    True
  end

end
