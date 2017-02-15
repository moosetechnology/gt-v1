Extension { #name : #Object }

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

{ #category : #'*GT-Inspector' }
Object >> gtInspectorHash [

	^ self identityHash.
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
					collect: [ :slot | slot name -> (slot read: self) ])).
	^ bindings
]
