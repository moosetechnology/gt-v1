Extension { #name : #MethodContext }

{ #category : #'*gt-inspector' }
MethodContext >> gtInspectorRetrieveVariableValuePairs [
	"Return a collection of 'temporary variables name -> value' for this method context"
	
	|fieldList|
	fieldList := OrderedCollection new.
	fieldList add: ('_thisContext' -> self ).
	
	"self == nil ifTrue: [^fieldList]."
	
	fieldList 
		add: ('stack top' -> (self stackPtr > 0 ifTrue: [self top]));
		add: ('all temp vars' -> self tempsAndValues).
	(self tempNames size > 0) ifTrue: [
		fieldList addAll: ((1 to: self tempNames size) collect: [ :index | 
			(self tempNames at: index ) -> (self debuggerMap namedTempAt: index in: self ) ] ) ].
		
	^ fieldList
]
