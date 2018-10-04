Extension { #name : #GTExampleMethod }

{ #category : #'*GT-Examples-Examples' }
GTExampleMethod classSide >> exampleFromMethod [
	<gtExample>
	^ GTExampleMethod fromClass: GTExampleMethodSubject class selector: #exampleFromMethod
]

{ #category : #'*GT-Examples-Examples' }
GTExampleMethod classSide >> exampleFromMethodNamed [
	<gtExample>
	^ GTExampleMethod fromClass: 'GTExampleMethodSubject class' selector: #exampleFromMethod
]
