Extension { #name : #GTExampleMethodIcon }

{ #category : #'*GT-Examples-Examples' }
GTExampleMethodIcon classSide >> exampleFromBase64String [
	<gtExample>
	^ (GTExampleMethodIcon fromClass: GTExampleFormIcon class selector: #dataFromBase64String) converter: #convertFromBase64String:
]

{ #category : #'*GT-Examples-Examples' }
GTExampleMethodIcon classSide >> exampleFromByteArray [
	<gtExample>
	^ (GTExampleMethodIcon fromClass: GTExampleFormIcon class selector: #dataFromByteArray) converter: #convertFromByteArray:
]
