Extension { #name : #GTExampleClassSubject }

{ #category : #'*GT-Examples-Examples' }
GTExampleClassSubject classSide >> exampleFromClass [
	<gtExample>
	^ GTExampleClassSubject fromClass: Magnitude
]

{ #category : #'*GT-Examples-Examples' }
GTExampleClassSubject classSide >> exampleFromClassNamed [
	<gtExample>
	^ GTExampleClassSubject fromClassNamed: 'Magnitude'
]
