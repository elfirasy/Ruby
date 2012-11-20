require 'socket'
puts "Starting up server..."

server = TCPServer.new('192.168.0.107', 2008)

while (session = server.accept)

 Thread.start do

   puts "log: Connection from #{session.peeraddr[2]} at
          #{session.peeraddr[3]}"
   puts "log: got input from client"

   input = session.gets
   puts input

   session.puts "Server: Welcome #{session.peeraddr[2]}\n"

   puts "log: got input from client"

   argv = session.gets
   puts "Client: #{argv}"

   puts "log: sending goodbye"
   session.puts "Server: Goodbye\n"
 end  #end thread conversation
end   #end loop