Class {
	#name : #GTSpotterBrickDarkThemer,
	#superclass : #GLMBrickDarkThemer,
	#category : #'GT-Spotter-Theme'
}

{ #category : #'brick-scrollbar' }
GTSpotterBrickDarkThemer >> scrollbarColor [

	^ Color black alpha: 0.5
]

{ #category : #'brick-scrollpane' }
GTSpotterBrickDarkThemer >> scrollpaneBackgroundColor [

	^ Color r: 0.3 g: 0.3 b: 0.3
]
