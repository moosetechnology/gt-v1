Extension { #name : #GTExampleResult }

{ #category : #'*GT-Examples-UI' }
GTExampleResult >> gtDisplayOn: aStream [
	self example gtDisplayOn: aStream. 
	
	self unexpectedError ifNotNil: [ 
		aStream nextPutAll: ' ['.
		self unexpectedError gtDisplayOn: aStream.
		aStream nextPutAll: ']' ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleResult >> gtDisplayValidityOn: aStream [
	self isSuccess ifTrue: [ ^ self ].
	
	aStream nextPutAll: ' ['.
	self unexpectedError gtDisplayOn: aStream.
	aStream nextPutAll: ']'
]
