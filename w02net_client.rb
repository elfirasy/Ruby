# input
task = ARGV.first

require 'socket'

s = TCPSocket.new 'localhost', 2000

if task == "--received"
	while line = s.gets # Read lines from socket
	  puts line         # and print them
	end
else
	puts "File can not transfered"
end

s.close             # close socket when done