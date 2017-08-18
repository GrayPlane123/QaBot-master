import socket
QASNAKE_HOST='127.0.0.1'
QASNAKE_PORT=50001

kw='天安门'
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((QASNAKE_HOST, QASNAKE_PORT))
client.send(kw.encode('utf8'))
response = client.recv(4096).decode('utf8')
print(response)
