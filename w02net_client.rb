# input
task = ARGV.first

require 'socket'
SIZE = 1024 * 1024 * 10

if task == "--received"
	TCPSocket.open('127.0.0.1' , 2000) do |socket|

		filename = socket.gets

		File.open("../../Documents/#{filename}", 'w') do |file|
			while chunk = client.read(SIZE)
			  file.write(chunk)
			end
		end

		while line = socket.gets
		  puts line
		end

		socket.close
	end 

else
	puts "File can not transfered"
	puts "type --received to transfer file"
end