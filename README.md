# A websocket server and client that enables chat-room functionality in the terminal
⋅⋅⋅* extremely lightweight terminal chatroom
⋅⋅⋅* users join the server directly via running the websocket client.rb file from terminal

## Client
### client.rb
⋅⋅⋅* requires 'websocket-client-simple' (gem install) and 'io/console' (built in)
⋅⋅⋅* connects to the server and handles outgoing/incoming messages via default $stdin and $stdout (STDIN, STDOUT)
⋅⋅⋅* script is minimal and currently supports options to show/hide input via activating noecho
⋅⋅⋅* next steps would be to either access terminal's input field from the script or use a modified gui. Ideally, we want users to be able to build strings in the terminal without the display interfering
⋅⋅⋅* To use, only the ip:port needs to be altered!


## Server
### server.rb
⋅⋅⋅* initializes an empty 'chatroom' instance when started
⋅⋅⋅* new websocket connections are linked to 'member' instances
⋅⋅⋅* the majority of work is done in the 'chatroom' instance, with the server only routing the events it is listening for
⋅⋅⋅* outside of printing to console while server is running, (and what is left in the terminal buffer), no traffic is logged to an external file
