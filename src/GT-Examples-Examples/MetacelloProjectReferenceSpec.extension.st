Extension { #name : #MetacelloProjectReferenceSpec }

{ #category : #'*GT-Examples-Examples' }
MetacelloProjectReferenceSpec class >> gtExampleProjectReferenceSpec [
	<gtExample>
	<label: 'Metacello project reference'>
	
	^ (ConfigurationOfGTInspectorCore project version: #development) projects anyOne
]
