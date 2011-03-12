Extension { #name : #ContextPart }

{ #category : #'*gt-inspector' }
ContextPart >> finderVariablesFor: anObject [
	| tempIndex |
	tempIndex := 0.
	^ ( super finderVariablesFor: anObject )
		addAll: ( anObject tempNames 
					collect: [ :tempName | ( '[', tempName ,']' ) -> (anObject debuggerMap namedTempAt: ( tempIndex := tempIndex + 1 ) in: anObject ) ] );
		yourself
]
