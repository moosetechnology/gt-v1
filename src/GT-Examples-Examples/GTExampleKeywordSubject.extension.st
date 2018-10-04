Extension { #name : #GTExampleKeywordSubject }

{ #category : #'*GT-Examples-Examples' }
GTExampleKeywordSubject classSide >> exampleFromString [
	<gtExample>
	^ GTExampleKeywordSubject fromString: 'gtExample'
]

{ #category : #'*GT-Examples-Examples' }
GTExampleKeywordSubject classSide >> exampleFromSymbol [
	<gtExample>
	^ GTExampleKeywordSubject fromSymbol: #something
]
