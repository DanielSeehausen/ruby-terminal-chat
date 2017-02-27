require 'websocket-client-simple'
require 'io/console' #needed for noecho

url = ARGV.shift || 'ws://192.168.5.68:8080'
ws = WebSocket::Client::Simple.connect url

ws.on :message do |msg|
  print "\r"
  puts msg
end

ws.on :open do
end

ws.on :close do |e|
  puts "*** CLOSED ***"
  exit 1
end

ws.on :error do |e|
  #TODO add attempt reconnect if error is server disconnected
  puts "Something went wrong: #{e}\nPerhaps the server is no longer running?. Exiting..."
  exit -1
end

CLIENT_COMMANDS = [
  "",
  "* /exit *> exit",
  "* /show *> shows text as you input (received messages will visually break your terminal input, but will not change what you have already typed in)",
  "* /hide *> the default hide input option for text",
  ""
]
hidden = true

loop do
  # to hide terminal input use nacho. otherwise just use msg = gets. Do not use both
  msg = hidden ? STDIN.noecho(&:gets).chomp : gets.chomp

  case msg.split.first
  when '/'
    CLIENT_COMMANDS.each {|command| puts command}
  when '/hide'
    puts " * INPUT HIDDEN = TRUE * "
    hidden = true
  when '/show'
    puts " * INPUT HIDDEN = FALSE * "
    hidden = false
  when "", "\n", nil
  when "/exit"
    puts "*** CLOSED BY CLIENT ***"
    exit 1
  else
    ws.send msg
  end

end
