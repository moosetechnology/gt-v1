Trait {
	#name : #TGTExampleIcon,
	#category : #'GT-Examples-Utils'
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

{ #category : #ui }
TGTExampleIcon >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 0>
	self exists ifFalse: [ ^ self ].
	
	self form gtInspectorFormIn: composite
]
