Extension { #name : #CompiledMethod }

{ #category : #'*gt-inspector' }
CompiledMethod >> gtInspectorBytecodeIn: composite [
	<gtInspectorPresentationOrder: 40> 
	composite text 
		title: 'Bytecode';
		display: [:anObject | anObject symbolic ]
]

{ #category : #'*gt-inspector' }
CompiledMethod >> gtInspectorRetrieveVariableValuePairs [
	| literalIndex |
	literalIndex := 0.
	^ OrderedCollection new 
		add: ( 'self' -> self); 
		add: ( 'header' -> self headerDescription );
		addAll: ( self literals collect: [ :aLiteral | 'literal', ( literalIndex := literalIndex + 1 ) asString -> aLiteral ] );
		add: ( 'all bytecodes' -> self symbolic );
		yourself

]

{ #category : #'*gt-inspector' }
CompiledMethod >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 30> 
	composite text 
		title: 'Source';
		forSmalltalk: [ :anObject | anObject methodClass ];
		display: [:anObject | anObject getSource ]
]
