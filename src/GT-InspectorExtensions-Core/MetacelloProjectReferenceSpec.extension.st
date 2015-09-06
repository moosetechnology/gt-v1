Extension { #name : #MetacelloProjectReferenceSpec }

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloProjectReferenceSpec class >> gtExampleProjectReferenceSpec [
	<gtExample>
	<label: 'Metacello project reference'>
	
	^ (ConfigurationOfGTInspectorCore project version: #development) projects anyOne
]

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloProjectReferenceSpec >> gtInspectorProjectsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Projects';
		display: [
			| projects |
			projects := OrderedCollection new.
			self
					projectDo: [:prj | projects add: prj ] 
					packageDo: [:pkg | ] 
					groupDo: [:ignored | ].
			projects ]

]
