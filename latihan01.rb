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

client.puts "Time elapsed: #{time} for transfering file #{filename}." and exit

#client receive file from server
require 'socket'

host = '127.0.0.1'
port = 9999
sock = TCPSocket.open(host, port)

data = sock.read
destFile = File.open('/path/to/saved/files', 'wb')
destFile.print data
destFile.close

#server sends client file over socket
require 'socket'
server = TCPServer.open(9999)

loop {
   Thread.start(server.accept) do |client|
#client.puts(Time.now.ctime)
file = open('/path/to/source/files', "rb")
fileContent = file.read
client.puts(fileContent)
client.close
end

}