Extension { #name : #TRCanvas }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
TRCanvas classSide >> gtExampleEmpty [
	<gtExample>
	<label: 'Empty canvas'>
	
	^ TRCanvas new
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
TRCanvas >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Canvas';
		initializeView: [ RTView new setCanvas: self ]
		
]
