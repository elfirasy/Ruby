# input
task = ARGV.first

require 'socket'
SIZE = 1024 * 1024 * 10

if task == "--received"
	TCPSocket.open('127.0.0.1' , 2000) do |socket|

		filename = socket.gets
		puts socket.gets
		puts socket.gets
		puts socket.gets

		File.open("../../Documents/#{filename}", 'w') do |file|
			while chunk = socket.read(SIZE)
			  	file.write(chunk)
			end
		end

		socket.close
	end 

elsif task == "--quit"
	puts "Server was closed"
	socket = TCPSocket.open('127.0.0.1', 2000)
	socket.close
else
	puts "File can not transfered"
	puts "type --received to transfer file"
end