Extension { #name : #GTExampleSubclassesSubject }

{ #category : #'*GT-Examples-UI' }
GTExampleSubclassesSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self exists ifFalse: [ ^ self ].
	
	super addToSelectorEnvironment: aSelectorEnvironment.
	self theSubclasses do: [ :class | 
		class asGTExampleSubject addToSelectorEnvironment: aSelectorEnvironment ]
]
