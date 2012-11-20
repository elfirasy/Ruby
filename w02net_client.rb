# input
task = ARGV.first

require 'socket'
require 'benchmark'
SIZE = 1024 * 1024 * 10

if task == "--received"
	TCPSocket.open('127.0.0.1' , 2000) do |socket|

		filename = socket.gets
		puts socket.gets
		puts socket.gets
		puts socket.gets

		time = Benchmark.realtime do
			File.open("../../Documents/#{filename}", 'w') do |file|
				while chunk = socket.read(SIZE)
				  	file.write(chunk)
				end
			end
		end
		
		file_size = File.size("../../Documents/#{filename}") / 1024 / 1024
		puts "Time elapsed: #{time}. Transferred #{file_size} MB. Transfer per second: #{file_size / time} MB"
		socket.close
	end 

elsif task == "--quit"
	puts "Server was closed"
	socket = TCPSocket.open('127.0.0.1', 2000)
	socket.puts "quit"
	socket.close
else
	puts "File can not transfered"
	puts "type --received to transfer file"
	puts "type --quit to shotdown server"
end