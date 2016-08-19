Extension { #name : #GTExampleTagSubject }

{ #category : #'*GT-Examples-UI' }
GTExampleTagSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self thePackage ifNil: [ ^ self ].
	
	self thePackage classes do: [ :class | 
		aSelectorEnvironment addClass: class ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleTagSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse subject Tag ' ,  self theTagName
		value: [ self theTag browse ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleTagSubject >> gtDisplayOn: aStream [
	self theTagName gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]
