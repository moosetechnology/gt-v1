Extension { #name : #GLMBrickThemer }

{ #category : #'*GT-Spotter' }
GLMBrickThemer >> spotterPinkThemer [

	^ self
		registerModule: GTSpotterWidgetPinkThemer new
		to: GTSpotterBrickPinkThemer new
]

{ #category : #'*GT-Spotter' }
GLMBrickThemer >> spotterThemer [

	^ self
		registerModule: GTSpotterWidgetThemer new
		to: GTSpotterBrickThemer new
]
