Class {
	#name : #GTSpotterTriangleRenderer,
	#superclass : #GLMBrickRenderer,
	#instVars : [
		'orientation'
	],
	#category : #'GT-Spotter-Renderer'
}

{ #category : #'mathematical functions' }
GTSpotterTriangleRenderer >> findTriangleEdgeLength: anInteger [

	^ 2 / 3 * (3 sqrt) * anInteger
]

{ #category : #accessing }
GTSpotterTriangleRenderer >> orientation [
	^ orientation ifNil: [ #bottom ]
]

{ #category : #accessing }
GTSpotterTriangleRenderer >> orientation: aSymbol [
	"can be #right #bottom #left #top"

	orientation := aSymbol
]

{ #category : #rendering }
GTSpotterTriangleRenderer >> render: aBrick on: aCanvas [
	
	self orientation = #right ifTrue: [ self renderRightTriangle: aBrick on: aCanvas ].
	self orientation = #bottom ifTrue: [ self renderBottomTriangle: aBrick on: aCanvas ].
	self orientation = #left ifTrue: [ self renderLeftTriangle: aBrick on: aCanvas ].
	self orientation = #top ifTrue: [ self renderTopTriangle: aBrick on: aCanvas ].
]

{ #category : #rendering }
GTSpotterTriangleRenderer >> renderBottomTriangle: aBrick on: aCanvas [
	|a b c width height|
	
	width := aBrick brickBounds width.
	height := aBrick brickBounds height.
	
	a := aBrick brickBounds topLeft + (((width / 2 - height) max: 0) @ 0).
	b := aBrick brickBounds topLeft + (((width / 2 + height) min: width) @ 0).
	c := aBrick brickBounds bottomLeft + (width / 2 @ 0).
	
	self renderTriangle: aBrick on: aCanvas with: { a asIntegerPoint . b asIntegerPoint . c asIntegerPoint}
]

{ #category : #rendering }
GTSpotterTriangleRenderer >> renderLeftTriangle: aBrick on: aCanvas [
	|a b c width height|
	
	width := aBrick brickBounds width.
	height := aBrick brickBounds height.
	
	a := aBrick brickBounds topRight + (0 @ ((height / 2 - width) max: 0)).
	b := aBrick brickBounds topRight + (0 @ ((height / 2 + width) min: height)).
	c := aBrick brickBounds topLeft + (0 @ (height / 2)).
	
	self renderTriangle: aBrick on: aCanvas with: { a asIntegerPoint . b asIntegerPoint . c asIntegerPoint}
]

{ #category : #rendering }
GTSpotterTriangleRenderer >> renderRightTriangle: aBrick on: aCanvas [
	|a b c width height gap|
	
	gap := aBrick themer spotterThemer previewArrowGapHack.
	aCanvas fillRectangle: (aBrick brickBounds withWidth: gap) color: aBrick color.
	
	width := aBrick brickBounds width - gap.
	height := aBrick brickBounds height.
	
	a := aBrick brickBounds topLeft + (gap @ ((height / 2 - width) max: 0)).
	b := aBrick brickBounds topLeft + (gap @ ((height / 2 + width) min: height)).
	c := aBrick brickBounds topRight + (0 @ (height / 2)).
	
	self renderTriangle: aBrick on: aCanvas with: { a asIntegerPoint . b asIntegerPoint . c asIntegerPoint}
]

{ #category : #rendering }
GTSpotterTriangleRenderer >> renderTopTriangle: aBrick on: aCanvas [
	|a b c width height|
	
	width := aBrick brickBounds width.
	height := aBrick brickBounds height.
	
	a := aBrick brickBounds bottomLeft + (((width / 2 - height) max: 0) @ 0).
	b := aBrick brickBounds bottomLeft + (((width / 2 + height) min: width) @ 0).
	c := aBrick brickBounds topLeft + (width / 2 @ 0).
	
	self renderTriangle: aBrick on: aCanvas with: { a asIntegerPoint . b asIntegerPoint . c asIntegerPoint}
]

{ #category : #rendering }
GTSpotterTriangleRenderer >> renderTriangle: aBrick on: aCanvas with: aCollection [

	aCanvas drawPolygon: aCollection color: aBrick color borderWidth: 0 borderColor: Color transparent
]
