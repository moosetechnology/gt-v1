Class {
	#name : #GTAGroup,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #accessing }
GTAGroup >> duration [
	^ self end - self start
]

{ #category : #accessing }
GTAGroup >> end [
	^ self last end
]

{ #category : #printing }
GTAGroup >> printHumanReadableOn: aStream [
	aStream 
		print: self size; 
		nextPutAll: ' events from '; 
		print: self start asDate; 
		nextPutAll: ' during '. 
	self duration printHumanReadableOn: aStream
]

{ #category : #accessing }
GTAGroup >> start [
	^ self first start
]
