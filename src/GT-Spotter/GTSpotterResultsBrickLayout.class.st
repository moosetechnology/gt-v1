Class {
	#name : #GTSpotterResultsBrickLayout,
	#superclass : #GLMBrickVerticalFillLinearLayout,
	#category : #'GT-Spotter-UI'
}

{ #category : #'as yet unclassified' }
GTSpotterResultsBrickLayout >> boundsOf: aBrick in: owner withArguments: aHashTable [
	
	aBrick height <= 0 ifTrue: [ ^ nil ].
	^ (owner layoutProperties paddingLeft@owner layoutProperties paddingTop) extent: (self extentOf: aBrick in: owner withArguments: aHashTable)
]

{ #category : #'as yet unclassified' }
GTSpotterResultsBrickLayout >> layout: aBrick in: newBounds [
	|isFirstVisible arguments|
	isFirstVisible := true.
	arguments := self prepareArgumentsFor: aBrick.
	
	aBrick subbricks
		inject: 0
		into: [ :topOffset :each |
			each layoutProperties floating = #none ifTrue: [
				|layoutBounds newTopOffset|
			
				layoutBounds := GLMBrickLayoutBounds on: (self boundsOf: each in: aBrick withArguments: arguments) of: each.
				layoutBounds translateBy: (0@topOffset).
				layoutBounds moveOuterToOrigin.
				
				newTopOffset := topOffset + layoutBounds outerBounds height.
				
				isFirstVisible ifTrue: [ each height > 0 ifTrue: [
						newTopOffset := topOffset + layoutBounds bounds height + each layoutProperties marginBottom.
						layoutBounds translateBy: (each layoutProperties marginTop * (-1)).
						isFirstVisible := false ] ].
				
				self setNewBounds: layoutBounds to: each in: aBrick.
				newTopOffset ]
			ifFalse: [ self layoutFloating: each in: newBounds. topOffset ] ]
]
