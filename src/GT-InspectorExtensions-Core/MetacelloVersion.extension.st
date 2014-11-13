Extension { #name : #MetacelloVersion }

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloVersion >> gtInspectorProjectsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Projects';
		display: [ self projects ]
]
