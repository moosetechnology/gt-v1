Class {
	#name : #GTACollection,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTACollection >> duration [
	^ self end - self start
]

{ #category : #accessing }
GTACollection >> end [
	self ifEmpty: [ ^ 0 ].
	^ self last end
]

{ #category : #accessing }
GTACollection >> start [
	self ifEmpty: [ ^ 0 ].
	^ self first start
]
