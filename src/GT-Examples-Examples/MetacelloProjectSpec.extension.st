Extension { #name : #MetacelloProjectSpec }

{ #category : #'*GT-Examples-Examples' }
MetacelloProjectSpec class >> gtExampleMetacelloSpec [
	<gtExample>
	<label: 'Metacello project reference'>
	
	^ (ConfigurationOfGTInspectorCore project version: #development) projects anyOne
]
