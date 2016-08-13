Extension { #name : #Symbol }

{ #category : #'*GT-Examples-Core' }
Symbol >> asGTExampleSubject [
	^ GTExampleKeywordSubject new 
		keyword: self;
		yourself
]
