Extension { #name : #MetacelloVersion }

{ #category : #'*GT-Examples-Examples' }
MetacelloVersion class >> gtExampleMetacelloVersion [
	<gtExample>
	<label: 'Metacello Version'>
	
	^ ConfigurationOfGTExamples project version: #development
]
