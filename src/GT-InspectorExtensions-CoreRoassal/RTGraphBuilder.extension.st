Extension { #name : #RTGraphBuilder }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTGraphBuilder classSide >> examplesProvider [

	^ RTGraphBuilderExample new 
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTGraphBuilder >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ self ]
]
