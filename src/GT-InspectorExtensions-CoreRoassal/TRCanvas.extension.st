Extension { #name : #TRCanvas }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
TRCanvas classSide >> gtExample [
	<gtExample: 'Example arc'>
	^ TRCanvasExample new arc
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
TRCanvas classSide >> gtExampleAtRandom [
	<gtExample: 'Random canvas'>
	^ TRCanvasExample new perform: TRCanvasExample selectors atRandom
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
TRCanvas classSide >> gtExampleEmpty [
	<gtExample: 'Empty canvas'>
	^ TRCanvas new
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
TRCanvas >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Canvas';
		initializeView: [ RTView new setCanvas: self ]
		
]
