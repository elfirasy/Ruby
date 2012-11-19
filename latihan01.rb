# input
filename = ARGV.first
ip_addr = ARGV.last
#puts "#{filename}"
#puts "#{ip_addr}"

# sender
require 'socket'

TCPSocket.open("#{ip_addr}" , 2000) do |socket| 
  File.open("#{filename}", 'rb') do |file|
      while chunk = file.read()
      socket.write(chunk)
    end
  end
end 

# receiver
require 'socket'
require 'benchmark'

server =  TCPServer.new("#{ip_addr}", 2000)
puts "Server listening..."            
client = server.accept       

time = Benchmark.realtime do
  File.open("../#{filename}", 'w') do |file|
    while chunk = client.read()
      file.write(chunk)
    end
  end
end

puts "Time elapsed: #{time} for transfering file #{filename}." and exit