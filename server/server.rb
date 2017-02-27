require 'em-websocket'
require 'set'
require_relative "chatroom.rb"

#ws.close(code = nil, body = nil)

EM.run {
  @port = 8080
  puts "#{Time.now}: Server starting on #{@port}"
  @chat = ChatRoom.new

  EM::WebSocket.run(:host => "0.0.0.0", :port => @port) do |ws|

    ws.onopen { |handshake|
      @rmip = ws.remote_ip
      puts handshake.headers
      puts "#{Time.now}: connection opened with - #{ws.remote_ip}"
      @chat.add_member(ws)
    }

    ws.onclose {
      puts "#{Time.now}: connection closed with - #{@rmip}"
      puts @chat
      @chat.remove_member(ws)
    }

    ws.onmessage { |msg|
      if msg.chomp != "\n"
        @chat.send_msg(ws, msg.chomp)
      end
    }

  end
}
