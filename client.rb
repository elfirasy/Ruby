require 'socket'

clientSession = TCPSocket.new( "localhost", 2008 )
puts "log: starting connection"
cmd = ARGV.first
puts "log: saying hello"
clientSession.puts "Client: Hello Server World!\n"
puts cmd if cmd != nil
clientSession.puts cmd if cmd != nil
#wait for messages from the server
## You've sent your message, now we need to make sure
## the session isn't closed, spit out any messages the server
## has to say, and check to see if any of those messages
## contain 'Goodbye'. If they do we can close the connection
 while !(clientSession.closed?) &&
          (serverMessage = clientSession.gets)
  ## lets output our server messages
  puts serverMessage
  #if one of the messages contains 'Goodbye' we'll disconnect
  ## we disconnect by 'closing' the session.
  if serverMessage.include?("Goodbye")
   puts "log: closing connection"
   clientSession.close
  end

 end #end loop