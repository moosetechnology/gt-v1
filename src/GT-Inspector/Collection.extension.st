Extension { #name : #Collection }

{ #category : #'*GT-Inspector' }
Collection >> gtInspectorInterestingObject [
	^ self size = 1
		ifTrue: [ self anyOne ]
		ifFalse: [ self ]
]
