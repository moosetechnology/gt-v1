Extension { #name : #SystemNavigation }

{ #category : #'*GT-Examples-Core' }
SystemNavigation >> examplesReferencesTo: aLiteral [
	^ GTExampleOrganizer instance examplesSelect: [ :each | 
			(each hasSubject: aLiteral)
				or: [ (each subjects anySatisfy: [ :subject | subject hasLiteralThorough: aLiteral ])
					or: [ (each hasMethod and: [ each method hasLiteralThorough: aLiteral ])
						or: [ (each methodClass name asString = aLiteral name asString) ] ] ] ]
]
