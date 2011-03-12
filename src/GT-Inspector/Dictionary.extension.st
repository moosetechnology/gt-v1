Extension { #name : #Dictionary }

{ #category : #'*gt-inspector' }
Dictionary >> objectFinderVariablesIn: composite [
	(composite list)
		title: 'Variables';
		display: [ :anObject | | literalIndex | 
			literalIndex := 0.
			OrderedCollection new 
				add: ( 'self' -> anObject); 
				add: ( 'tally' -> anObject size );
				add: ( 'array' -> anObject array );
				addAll: ( anObject keysSortedSafely asArray collect: [ :key | key -> (anObject at: key)]);
				yourself
			 ];
		format: [ :assoc | assoc key asString , ' : ' , (assoc value printString copyFrom: 1 to: ((50 min: assoc value printString size) max: 0)) ];
		icon: [ :each |  OBMorphicIcons iconNamed: each value class theNonMetaClass browserIcon ];
		send: #value
]
