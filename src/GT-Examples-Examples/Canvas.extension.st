Extension { #name : #Canvas }

{ #category : #'*GT-Examples-Examples' }
Canvas class >> gtExampleNullCanvas [
	<gtExample>
	<label: 'Canvas: Null'>
	
	^ NullCanvas new
]

{ #category : #'*GT-Examples-Examples' }
Canvas class >> gtExampleWorldCanvas [
	<gtExample>
	<label: 'Canvas: World'>
	
	^ Canvas new
]

{ #category : #'*GT-Examples-Examples' }
Canvas class >> gtExampleWorldCanvasWithAlpha [
	<gtExample>
	<label: 'Canvas: World+ALpha'>
	
	^ (AlphaBlendingCanvas on: Canvas new)	
		alpha: 0.3
]

{ #category : #'*GT-Examples-Examples' }
Canvas class >> gtExampleWorldCanvasWithShadow [
	<gtExample>
	<label: 'Canvas: World+Shadow'>
	
	^ (ShadowDrawingCanvas on: Canvas new)
		shadowColor: (Color black alpha: 0.5)
]
