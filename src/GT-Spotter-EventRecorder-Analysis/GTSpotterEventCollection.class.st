Class {
	#name : #GTSpotterEventCollection,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #accessing }
GTSpotterEventCollection >> duration [
	^ self stop - self start
]

{ #category : #accessing }
GTSpotterEventCollection >> start [
	^ self first timestamp
]

{ #category : #accessing }
GTSpotterEventCollection >> stop [
	^ self last timestamp
]
