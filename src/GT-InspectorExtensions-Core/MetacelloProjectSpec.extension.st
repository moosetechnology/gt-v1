Extension { #name : #MetacelloProjectSpec }

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloProjectSpec class >> gtExampleMetacelloSpec [
	<gtExample: 'Metacello project reference'>
	^ (ConfigurationOfGTInspectorCore project version: #development) projects anyOne
]

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloProjectSpec >> gtInspectorPackagesIn: composite [
	<gtInspectorPresentationOrder: 40>
	self version gtInspectorPackagesIn: composite
]

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloProjectSpec >> gtInspectorProjectsIn: composite [
	<gtInspectorPresentationOrder: 40>
	self version gtInspectorProjectsIn: composite
]
