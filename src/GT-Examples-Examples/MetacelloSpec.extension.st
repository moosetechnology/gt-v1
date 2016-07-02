Extension { #name : #MetacelloSpec }

{ #category : #'*GT-Examples-Examples' }
MetacelloSpec class >> gtExampleMetacelloSpec [
	<gtExample>
	<label: 'Metacello group reference'>
	
	^ (ConfigurationOfGTInspectorCore project version: #development) groups anyOne
]
