Extension { #name : #MetacelloAbstractPackageSpec }

{ #category : #'*GT-Examples-Examples' }
MetacelloAbstractPackageSpec class >> gtExamplePackageSpec [
	<gtExample>
	<label: 'Metacello package reference'>
	
	^ (ConfigurationOfGTExamples project version: #development) packages anyOne
]
