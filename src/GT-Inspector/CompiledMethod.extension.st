Extension { #name : #CompiledMethod }

{ #category : #'*gt-inspector' }
CompiledMethod >> objectFinderItemsIn: composite [

]

{ #category : #'*gt-inspector' }
CompiledMethod >> objectFinderVariablesIn: composite [
	(composite list)
		title: 'Variables';
		display: [ :anObject | | literalIndex | 
			literalIndex := 0.
			OrderedCollection new 
				add: ( 'self' -> anObject); 
				add: ( 'header' -> anObject headerDescription );
				addAll: ( anObject literals collect: [ :aLiteral | 'literal', ( literalIndex := literalIndex + 1 ) asString -> aLiteral ] );
				add: ( 'all bytecodes' -> anObject symbolic );
				yourself
			 ];
		format: [ :assoc | assoc key asString , ' : ' , (assoc value printString copyFrom: 1 to: ((50 min: assoc value printString size) max: 0)) ];
		icon: [ :each |  OBMorphicIcons iconNamed: each value class theNonMetaClass browserIcon ];
		send: #value
]
