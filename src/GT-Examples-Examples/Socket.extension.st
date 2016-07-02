Extension { #name : #Socket }

{ #category : #'*GT-Examples-Examples' }
Socket class >> gtExampleTCPSocket [
	<gtExample>
	<label: 'TCP Socket'>
	
	^ Socket newTCP
]

{ #category : #'*GT-Examples-Examples' }
Socket class >> gtExampleUDPSocket [
	<gtExample>
	<label: 'UDP Socket'>
	
	^ Socket newUDP
]
