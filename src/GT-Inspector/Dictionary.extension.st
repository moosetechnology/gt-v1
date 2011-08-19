Extension { #name : #Dictionary }

{ #category : #'*gt-inspector' }
Dictionary >> finderVariablesFor: anObject [  
	^ OrderedCollection new 
		add: ( 'self' -> anObject); 
		add: ( 'tally' -> anObject size );
		add: ( 'array' -> anObject array );
		yourself

]
