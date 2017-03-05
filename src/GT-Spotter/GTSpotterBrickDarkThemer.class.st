Class {
	#name : #GTSpotterBrickDarkThemer,
	#superclass : #GTSpotterBrickThemer,
	#category : #'GT-Spotter-Theme'
}

{ #category : #'brick-rubric' }
GTSpotterBrickDarkThemer >> rubricBackgroundColor [

	^ self spotterThemer backgroundColor
]

{ #category : #'brick-scrollpane' }
GTSpotterBrickDarkThemer >> rubricTextColor [
	^UITheme current textColor
]

{ #category : #'brick-scrollbar' }
GTSpotterBrickDarkThemer >> scrollbarColor [

	^ UITheme current scrollbarColor alpha: 0.5
]

{ #category : #'brick-scrollpane' }
GTSpotterBrickDarkThemer >> scrollpaneBackgroundColor [

	^ self spotterThemer backgroundColor
]

{ #category : #'brick-scrollpane' }
GTSpotterBrickDarkThemer >> textColor [
	^UITheme current textColor
]
