Extension { #name : #Dictionary }

{ #category : #'*gt-inspector' }
Dictionary >> gtInspectorRetrieveVariableValuePairs [  
	^ OrderedCollection new 
		add: ( 'self' -> self); 
		add: ( 'tally' -> self size );
		add: ( 'array' -> self array );
		yourself

]
