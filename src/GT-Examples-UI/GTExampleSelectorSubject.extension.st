Extension { #name : #GTExampleSelectorSubject }

{ #category : #'*GT-Examples-UI' }
GTExampleSelectorSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self selector ifNil: [ ^ self ].
	
	self theClasses do: [ :class | 
		aSelectorEnvironment addClass: class selector: self selector ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleSelectorSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse selector-subject "' ,  self selector , '"'
		value: [ 
			| env |
			self addToSelectorEnvironment: (env := RBSelectorEnvironment new).
			env browse ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleSelectorSubject >> gtDisplayOn: aStream [
	self selector gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]
