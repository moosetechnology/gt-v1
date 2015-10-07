Extension { #name : #SocketStream }

{ #category : #'*GT-InspectorExtensions-Core' }
SocketStream class >> gtExampleOnTCPSocket [
	<gtExample>
	<label: 'Stream on TCP socket'>
	
	^ SocketStream on: Socket newTCP
]

{ #category : #'*GT-InspectorExtensions-Core' }
SocketStream class >> gtExampleOnUDPSocket [
	<gtExample>
	<label: 'Stream on UDP socket'>
	
	^ SocketStream on: Socket newUDP
]

{ #category : #'*GT-InspectorExtensions-Core' }
SocketStream >> gtInspectorSocketInfo: composite [
	<gtInspectorPresentationOrder: 5>
	^ self socket ifNotNil: [ :aSocket | aSocket gtInspectorSocketInfo: composite ]
]
