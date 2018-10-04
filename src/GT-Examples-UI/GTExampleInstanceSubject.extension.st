Extension { #name : #GTExampleInstanceSubject }

{ #category : #'*GT-Examples-UI' }
GTExampleInstanceSubject >> forNautilus: aBlock [
	aBlock
		value: #'Inspect instance-subject "' ,  self instance gtDisplayString , '"'
		value: [ self instance inspect ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleInstanceSubject >> gtDisplayOn: aStream [
	self instance gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]
