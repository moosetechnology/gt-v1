Extension { #name : #Object }

{ #category : #'*GT-Inspector-Examples-Core-private' }
Object >> detachFromSystem [
]

{ #category : #'*GT-Inspector-Examples-Core' }
Object >> equalsExample: anExampleOrExampleFutureOrSomethingElse [
	^ false
]

{ #category : #'*GT-Inspector' }
Object >> gtDisplayOn: stream [
	"This offers a means to customize how the object is shown in the inspector"
	^ self printOn: stream
]

{ #category : #'*GT-Inspector' }
Object >> gtDisplayString [
	"This offers a means to customize how the object is shown in the inspector.
	Do not override this method. Override gtDisplayOn: instead"
		
	| limitedString limit |
	limit := 1000.
	limitedString := String streamContents: [:s | self gtDisplayOn: s] limitedTo: limit.
	limitedString size < limit ifTrue: [^ limitedString].
	^ limitedString , ' ...'
]

{ #category : #'*GT-Inspector-Examples-UI' }
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

{ #category : #'*GT-Inspector-Examples-Core' }
Object >> gtExamples [
	^ self class gtExamples
]

{ #category : #'*GT-Inspector-Examples-UI' }
Object >> gtExamplesContained [
	^ [ self gtExamples ]
		on: Error
		do: [ #() ]
]

{ #category : #'*GT-Inspector' }
Object >> gtInspectorInterestingObject [
	^ self
]

{ #category : #'*GT-Inspector' }
Object >> gtInspectorRawIn: composite [
	"This is the most basic presentation showing the state of the object"
	^ composite custom: GTObjectVariablesBrowser new
]

{ #category : #'*GT-Inspector' }
Object >> gtInspectorVariableValuePairs [
	"This is a helper method that returns a collection of 
		variable_name -> value
	for the current object.
	Subclasses can override it to specialize what appears in the variables presentation"
	| bindings |
	bindings := OrderedCollection new.
					
	1 to: (self basicSize min: 21) do: [ :index | 
		bindings add: (index "asString""asTwoCharacterString" -> (self basicAt: index)) ].
	
	((self basicSize - 20) max: 22) to: (self basicSize) do: [ :index | "self haltIf: [ index = 99 ]."
		bindings add: (index "asString" -> (self basicAt: index)) ].
	
	bindings
		addAll: ((self class allSlots 
					collect: [ :slot | slot name -> (slot read: self) ]) sort asOrderedCollection).
	^ bindings
]

{ #category : #'*GT-Inspector-Examples-Core' }
Object >> isGTExample [
	
	^ false
]
