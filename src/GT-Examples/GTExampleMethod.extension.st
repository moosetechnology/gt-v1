Extension { #name : #GTExampleMethod }

{ #category : #'*GT-Examples-UI' }
GTExampleMethod >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock
		value: #'Browse dependency Method ' ,  self method gtDisplayString
		value: [ self method browse ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleMethod >> gtDisplayValidityOn: aStream [
	self isValid ifTrue: [ ^ self ].
	
	self exists ifFalse: [ ^ aStream nextPutAll: ' [does not exist]' ].
	self hasValidArguments ifFalse: [ ^ aStream nextPutAll: '[invalid arguments]' ].
	aStream nextPutAll: ' [invalid]'
]
