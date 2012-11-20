require 'socket'
receiver = UDPSocket.open()
receiver.bind("0.0.0.0", 10000)

# get file data
filename = receiver.recv(65535)
filedata = receiver.recv(65535)

# write data to file
destFile = File.open("../../Documents/#{filename}", 'wb')
destFile.print filedata

# notification
puts "File transfer success!"

receiver.close