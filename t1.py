from http import server
import socket
ip_port = (' ',10055)#ip et port
s = socket.socket()
s.connect(ip_port)

while True:
    inp = input("bonjour")#position
    if not inp:
        continue
    s.sendall(inp.encode())

    if inp == "quit":
        print("reussir")
        break
    server_reply = s.recv(1024).decode()
    print(server_reply)
s.close()