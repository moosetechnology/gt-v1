Class {
	#name : #GTSpotterBrickPinkThemer,
	#superclass : #GTSpotterBrickThemer,
	#category : #'GT-Spotter-Theme'
}

{ #category : #popup }
GTSpotterBrickPinkThemer >> popupHelpThemer [

	^ self
		registerModule: GTSpotterPopupHelpPinkThemer new
		to: self
		named: #popupThemer
]

{ #category : #'brick-scrollbar' }
GTSpotterBrickPinkThemer >> scrollbarColor [

	^ self spotterThemer borderColor alpha: 0.5
]

{ #category : #'*GT-Spotter' }
GTSpotterBrickPinkThemer >> spotterThemer [

	^ self spotterPinkThemer
]

{ #category : #brick }
GTSpotterBrickPinkThemer >> textColor [

	^ self spotterThemer searchFieldTextColor
]

{ #category : #brick }
GTSpotterBrickPinkThemer >> textLightColor [

	^ self spotterThemer borderColor
]
