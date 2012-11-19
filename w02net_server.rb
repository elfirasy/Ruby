# input
filename = ARGV.first
ip_addr = ARGV.last

require 'socket'
require 'benchmark'
SIZE = 1024 * 1024 * 10

server =  TCPServer.new("#{ip_addr}", 2000)
puts "Server listening..."
loop do      
	client = server.accept

	File.open("#{filename}", 'rb') do |file|
	  	while chunk = file.read()
	  		socket.write(chunk)
		end
	end

	client.puts "#{filename}"
	client.puts "Hello !"
	client.puts "File #{filename} has been success transfered to IP #{ip_addr}"
	client.puts "Time transfered is #{Time.now}"
	client.close
end