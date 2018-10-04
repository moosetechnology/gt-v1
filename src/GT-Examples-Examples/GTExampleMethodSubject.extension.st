Extension { #name : #GTExampleMethodSubject }

{ #category : #'*GT-Examples-Examples' }
GTExampleMethodSubject classSide >> exampleFromMethod [
	<gtExample>
	^ GTExampleMethodSubject fromClass: Magnitude selector: #max:
]

{ #category : #'*GT-Examples-Examples' }
GTExampleMethodSubject classSide >> exampleFromMethodNamed [
	<gtExample>
	^ GTExampleMethodSubject fromClassNamed: 'Magnitude' selector: #min:max:
]
