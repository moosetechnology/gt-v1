Extension { #name : #SystemNavigation }

{ #category : #'*GT-Inspector-Examples-UI' }
SystemNavigation >> examplesReferencesTo: aLiteral [
	^ GTExampleFinder gtExamples select: [ :each | 
			(each hasSubject: aLiteral)
				or: [ (each method hasLiteralThorough: aLiteral) ] ]
]
