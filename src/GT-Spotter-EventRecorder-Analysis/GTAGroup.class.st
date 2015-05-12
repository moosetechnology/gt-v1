Class {
	#name : #GTAGroup,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #accessing }
GTAGroup >> end [
	^ self last end
]

{ #category : #accessing }
GTAGroup >> start [
	^ self first start
]
