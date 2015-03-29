Class {
	#name : #GTSpotterFirstExitPattern,
	#superclass : #GTSpotterFilterPattern,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #execute }
GTSpotterFirstExitPattern >> execute [
	((self events size >= 1) and: [ 
		self events first class = GTSpotterRecorderExitAnnouncementEvent ])
			ifTrue: [ self events remove: self events first ]
]
