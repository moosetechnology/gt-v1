Class {
	#name : #GTASessionBookmark,
	#superclass : #GTABookmark,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #'as yet unclassified' }
GTASessionBookmark >> from: aCollection [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
GTASessionBookmark >> path [
	^ Array
		with: self class
		with: self item computerUUID
		with: self item start
		with: self description
		with: self dateAndTime
]
