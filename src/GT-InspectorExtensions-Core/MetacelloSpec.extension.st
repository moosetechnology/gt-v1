Extension { #name : #MetacelloSpec }

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloSpec class >> gtExampleMetacelloSpec [
	<gtExample>
	<label: 'Metacello group reference'>
	
	^ (ConfigurationOfGTInspectorCore project version: #development) groups anyOne
]

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloSpec >> gtInspectorCodeIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite pharoPlayground 
		title: 'Code';
		display: [ 
			String streamContents: [ :s | self configMethodOn: s indent: 0] ]

]
