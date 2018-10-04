Trait {
	#name : #TGTExampleIcon,
	#category : #'GT-Examples-Organization'
}

{ #category : #private }
TGTExampleIcon >> basicForm [
	^ self subclassResponsibility
]

{ #category : #'accessing-dynamic' }
TGTExampleIcon >> form [
	^ self exists
		ifTrue: [ self basicForm ]
		ifFalse: [ nil ]
]
