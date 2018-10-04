Extension { #name : #GTExampleAspect }

{ #category : #'*GT-Examples-UI' }
GTExampleAspect >> addToSelectorEnvironment: aSelectorEnvironment [
]

{ #category : #'*GT-Examples-UI' }
GTExampleAspect >> forNautilus: aBlock [
	
]

{ #category : #'*GT-Examples-UI' }
GTExampleAspect >> gtDisplayValidityOn: aStream [
	self isValid ifTrue: [ ^ self ].
	
	self exists ifFalse: [ ^ aStream nextPutAll: ' [does not exist]' ].
	aStream nextPutAll: ' [invalid]'
]
