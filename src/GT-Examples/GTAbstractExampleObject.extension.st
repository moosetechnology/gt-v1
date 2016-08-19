Extension { #name : #GTAbstractExampleObject }

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleObject >> addToSelectorEnvironment: aSelectorEnvironment [
]

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleObject >> forNautilus: aBlock [
	
]

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleObject >> gtDisplayValidityOn: aStream [
	self isValid ifTrue: [ ^ self ].
	
	self exists ifFalse: [ ^ aStream nextPutAll: ' [does not exist]' ].
	aStream nextPutAll: ' [invalid]'
]
