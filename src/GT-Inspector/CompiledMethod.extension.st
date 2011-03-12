Extension { #name : #CompiledMethod }

{ #category : #'*gt-inspector' }
CompiledMethod >> finderVariablesFor: anObject [
	| literalIndex |
	literalIndex := 0.
	^ OrderedCollection new 
		add: ( 'self' -> anObject); 
		add: ( 'header' -> anObject headerDescription );
		addAll: ( anObject literals collect: [ :aLiteral | 'literal', ( literalIndex := literalIndex + 1 ) asString -> aLiteral ] );
		add: ( 'all bytecodes' -> anObject symbolic );
		yourself

]

{ #category : #'*gt-inspector' }
CompiledMethod >> objectFinderItemsIn: composite [

]
