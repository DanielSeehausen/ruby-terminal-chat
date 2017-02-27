require 'websocket-client-simple'
require 'io/console'

url = ARGV.shift || 'ws://192.168.5.68:8080'
ws = WebSocket::Client::Simple.connect url

ws.on :message do |msg|
  print "\r"
  puts msg
end

ws.on :open do
end

ws.on :close do |e|
  puts "*** CLOSING ***"
  p e
  exit 1
end

ws.on :error do |e|
  #TODO add attempt reconnect if error is server disconnected
  p e
  puts "Something went wrong (perhaps the server is no longer running?). Exiting..."
  exit -1
end

loop do
  # to hide terminal input use nacho. otherwise just use msg = gets. Do not use both
  ws.send STDIN.noecho(&:gets)
  # msg = gets

  #don't disable this you naughty naughty its checking on the server side as well
  # ws.send msg if msg.to_s != "\n"

end
