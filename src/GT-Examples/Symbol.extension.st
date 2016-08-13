Extension { #name : #Symbol }

{ #category : #'*GT-Examples-Core' }
Symbol >> asGTExampleSubject [
	^ GTExampleKeywordSubject fromSymbol: self
]
