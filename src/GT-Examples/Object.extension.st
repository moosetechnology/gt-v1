Extension { #name : #Object }

{ #category : #'*GT-Examples-Core-private' }
Object >> detachFromSystem [
]

{ #category : #'*GT-Examples-Core' }
Object >> equalsExample: anExampleOrExampleFutureOrSomethingElse [
	^ false
]

{ #category : #'*GT-Examples-Core' }
Object >> gtExampleContext [
	^ self class gtExampleContext
]

{ #category : #'*GT-Examples-Core' }
Object class >> gtExampleContext [
	^ GTCurrentExampleContext value
]

{ #category : #'*GT-Examples-UI' }
Object >> gtExampleSourceIn: composite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 100>
	| previousRawSelection |
	"we first check to see if we have at least two panes, because only
	if we have two panes does it make sense to check the raw selection of the previous pane"
	((aGTInspector isKindOf: GTInspector) and: [aGTInspector first panes size >= 2]) ifFalse: [ ^ self ].
	
	previousRawSelection := (aGTInspector first panes reverse second port: #rawSelection) value.
	previousRawSelection isGTExample ifTrue: [ 
		previousRawSelection gtInspectorSourceIn: composite ]
]

{ #category : #'*GT-Examples-Core' }
Object >> gtExamples [
	^ self class gtExamples
]

{ #category : #'*GT-Examples-UI' }
Object >> gtExamplesContained [
	^ [ self gtExamples ]
		on: Error
		do: [ #() ]
]

{ #category : #'*GT-Examples-Core' }
Object >> isGTExample [
	
	^ false
]
