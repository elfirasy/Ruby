require 'socket'

# input
IP = ARGV.last
FILE = ARGV.first

sender = UDPSocket.open()

sockaddr = Socket.pack_sockaddr_in(10000, "#{IP}")
sender.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, 1)

# read file
file = open("#{FILE}", "rb")
fileContent = file.read

# send file name
sender.send("#{FILE}", 0, sockaddr)

# send file content
sender.send(fileContent, 0, sockaddr)

sender.close
