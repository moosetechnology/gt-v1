Extension { #name : #Socket }

{ #category : #'*GT-InspectorExtensions-Core' }
Socket class >> gtExampleTCPSocket [
	<gtExample>
	<label: 'TCP Socket'>
	
	^ Socket newTCP
]

{ #category : #'*GT-InspectorExtensions-Core' }
Socket class >> gtExampleUDPSocket [
	<gtExample>
	<label: 'UDP Socket'>
	
	^ Socket newUDP
]

{ #category : #'*GT-InspectorExtensions-Core' }
Socket >> gtInspectorSocketInfo: composite [
	<gtInspectorPresentationOrder: 1>
	^ ((Dictionary new
		at: #isConnected put: self isConnected;
		at: #address put: self localAddress;
		at: #port put: self localPort;
		at: #isOtherEndClosed put: self isOtherEndClosed;
		at: #isThisEndClosed put: self isThisEndClosed;
		at: #isUnconnected put: self isUnconnected;
		at: #isUnconnectedOrInvalid put: self isUnconnectedOrInvalid;
		at: #isValid put: self isValid;
		at: #isWaitingForConnection put: self isWaitingForConnection;
		yourself)
			gtInspectorItemsIn: composite)
				title: 'Socket Info'
]
