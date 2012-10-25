Extension { #name : #MethodContext }

{ #category : #'*gt-inspector' }
MethodContext >> gtInspectorRetrieveTemporaryVariableValuePairs [
	"Return a collection of 'temporary variables name -> value' for this method context"
	
	|fieldList|
	fieldList := OrderedCollection new.

	(self tempNames size > 0) ifTrue: [
		fieldList addAll: ((1 to: self tempNames size) collect: [ :index | 
			(self tempNames at: index ) -> (self debuggerMap namedTempAt: index in: self ) ] ) ].
		
	^ fieldList
]

{ #category : #'*gt-inspector' }
MethodContext >> gtInspectorTemporaryVariablesIn: composite [
	<gtInspectorPresentationOrder: 5>  
		
	(composite custom: (GTObjectVariablesBrowser new browser startOn: self gtInspectorRetrieveTemporaryVariableValuePairs)) 
		display: [:aContext | self gtInspectorRetrieveTemporaryVariableValuePairs inspect. self gtInspectorRetrieveTemporaryVariableValuePairs];
		title: 'Temporary Variables'.
]
