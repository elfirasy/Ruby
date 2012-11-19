# input
filename = ARGV.first
ip_addr = ARGV.last

require 'socket'
require 'benchmark'

server =  TCPServer.new("#{ip_addr}", 2000)
puts "Server listening..."            


client = server.accept    # Wait for a client to connect

time = Benchmark.realtime do
File.open("../#{filename}", 'w') do |file|
		while chunk = client.read()
		  file.write(chunk)
		end
	end
end

client.puts "Hello !"
client.puts "File #{filename} has been success transfered to IP #{ip_addr}"
client.puts "Time elapsed: #{time} for transfering file #{filename}."
client.puts "Time transfered is #{Time.now}"

client.close
server.close
