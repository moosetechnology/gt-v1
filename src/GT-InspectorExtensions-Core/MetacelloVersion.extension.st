Extension { #name : #MetacelloVersion }

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloVersion >> gtInspectorPackagesIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Packages';
		display: [ self spec packages packageSpecsInLoadOrder select: [ :each | 
				each isKindOf: MetacelloPackageSpec ] ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloVersion >> gtInspectorProjectsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Projects';
		display: [ self projects ]
]
