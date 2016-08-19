Extension { #name : #GTExampleClassSubject }

{ #category : #'*GT-Examples-UI' }
GTExampleClassSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self exists ifFalse: [ ^ self ].
	
	aSelectorEnvironment addClass: self theClass
]

{ #category : #'*GT-Examples-UI' }
GTExampleClassSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse subject Class ' ,  self theClassName 
		value: [ self theClass browse ]

]

{ #category : #'*GT-Examples-UI' }
GTExampleClassSubject >> gtDisplayOn: aStream [
	self theClassName gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]
