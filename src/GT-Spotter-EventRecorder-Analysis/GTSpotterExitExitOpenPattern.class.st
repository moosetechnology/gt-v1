Class {
	#name : #GTSpotterExitExitOpenPattern,
	#superclass : #GTSpotterFilterPattern,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #execute }
GTSpotterExitExitOpenPattern >> execute [
	| toRemove |
	toRemove := OrderedCollection new.
	self events withIndexDo: [ :event :index |
		((event class = GTSpotterRecorderExitAnnouncementEvent) and: [ 
			(self events size >= (index + 2)) and: [
				((self events at: index + 1) class = GTSpotterRecorderExitAnnouncementEvent) and: [ 
					(self events at: index + 2) class = GTSpotterRecorderOpenEvent ] ] ])
						ifTrue: [ toRemove add: (self events at: index + 1) ]
		].
	self events removeAll: toRemove.
]
