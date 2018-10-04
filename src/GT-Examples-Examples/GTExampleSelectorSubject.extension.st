Extension { #name : #GTExampleSelectorSubject }

{ #category : #'*GT-Examples-Examples' }
GTExampleSelectorSubject classSide >> exampleFromString [
	<gtExample>
	^ GTExampleSelectorSubject fromString: 'size'
]

{ #category : #'*GT-Examples-Examples' }
GTExampleSelectorSubject classSide >> exampleFromSymbol [
	<gtExample>
	^ GTExampleSelectorSubject fromSymbol: #isEmpty
]
