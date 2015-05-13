Class {
	#name : #GTASessionBookmark,
	#superclass : #GTABookmark,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #initialization }
GTASessionBookmark >> from: aCollection computers: aGTAComputers [ 
	| computer session |
	computer := aGTAComputers detect: [ :each | each computerUUID = aCollection second ].
	session := computer detect: [ :each | each start = aCollection third ].
	self
		item: session;
		description: aCollection fourth;
		dateAndTime: aCollection fifth.
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
