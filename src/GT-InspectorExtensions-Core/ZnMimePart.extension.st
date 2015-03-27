Extension { #name : #ZnMimePart }

{ #category : #'*GT-InspectorExtensions-Core' }
ZnMimePart class >> gtExampleEmptyField [
	<gtExample: 'Empty field'>
	^ self fieldName: 'value' value: ''
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnMimePart class >> gtExampleField [
	<gtExample: 'Field'>
	^ self fieldName: 'message' value: 'hello world'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnMimePart class >> gtExampleFile [
	<gtExample: 'File'>
	^ self 
		fieldName: 'file' 
		fileName: 'message.txt' 
		entity: (ZnEntity text: 'Hello World')
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnMimePart >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 40>
	self hasEntity
		ifTrue: [ 
			self contentType isBinary
				ifTrue: [ 
					composite table
						title: 'Contents';
						display: [ {'entity' -> self entity} ];
						column: 'Key' evaluated: #key;
						column: 'Value' evaluated: #value;
						send: #value ]
				ifFalse: [ 
					composite rubricText
						title: 'Contents';
						format: self contents ] ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnMimePart >> gtInspectorHeadersIn: composite [ 
	<gtInspectorPresentationOrder: 30>
	^ (self headers gtInspectorHeadersIn: composite) 
		title: [:anObject | self headers headers size asString , ' headers' ]
]
