Extension { #name : #GTExampleUnexpectedExceptionRaised }

{ #category : #'*GT-Examples-UI' }
GTExampleUnexpectedExceptionRaised >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream nextPutAll: ' ('.
	self unexpectedError gtDisplayOn: aStream.
	aStream nextPutAll: ')'.
]
