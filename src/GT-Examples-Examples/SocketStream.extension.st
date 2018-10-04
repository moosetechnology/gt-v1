Extension { #name : #SocketStream }

{ #category : #'*GT-Examples-Examples' }
SocketStream class >> gtExampleOnTCPSocket [
	<gtExample>
	<label: 'Stream on TCP socket'>
	
	^ SocketStream on: Socket newTCP
]

{ #category : #'*GT-Examples-Examples' }
SocketStream class >> gtExampleOnUDPSocket [
	<gtExample>
	<label: 'Stream on UDP socket'>
	
	^ SocketStream on: Socket newUDP
]
