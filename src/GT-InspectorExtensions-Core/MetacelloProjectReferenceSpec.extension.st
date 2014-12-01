Extension { #name : #MetacelloProjectReferenceSpec }

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloProjectReferenceSpec >> gtInspectorProjectsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Projects';
		display: [
			| projects |
			projects := OrderedCollection new.
			(ConfigurationOfGlamour project version: #development) spec 
					projectDo: [:prj | projects add: prj ] 
					packageDo: [:pkg | ] 
					groupDo: [:ignored | ].
			projects ]

]
