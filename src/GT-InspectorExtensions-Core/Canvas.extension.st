Extension { #name : #Canvas }

{ #category : #'*GT-InspectorExtensions-Core' }
Canvas class >> gtExampleNullCanvas [
	<gtExample: 'Canvas: Null'>
	^ NullCanvas new
]

{ #category : #'*GT-InspectorExtensions-Core' }
Canvas class >> gtExampleWorldCanvas [
	<gtExample: 'Canvas: World'>
	^ Canvas new
]

{ #category : #'*GT-InspectorExtensions-Core' }
Canvas class >> gtExampleWorldCanvasWithAlpha [
	<gtExample: 'Canvas: World+ALpha'>
	^ (AlphaBlendingCanvas on: Canvas new)	
		alpha: 0.3
]

{ #category : #'*GT-InspectorExtensions-Core' }
Canvas class >> gtExampleWorldCanvasWithShadow [
	<gtExample: 'Canvas: World+Shadow'>
	^ (ShadowDrawingCanvas on: Canvas new)
		shadowColor: (Color black alpha: 0.5)
]

{ #category : #'*GT-InspectorExtensions-Core' }
Canvas >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ self form gtInspectorFormIn: composite 
]
