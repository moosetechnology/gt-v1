Class {
	#name : #GTAComputerBookmark,
	#superclass : #GTABookmark,
	#category : #'GT-Spotter-EventRecorder-Analysis-Bookmarks'
}

{ #category : #accessing }
GTAComputerBookmark >> from: aCollection computers: aGTAComputers [ 
	| computer |
	computer := aGTAComputers detect: [ :each | each computerUUID = aCollection second ].
	self
		item: computer;
		description: aCollection third;
		dateAndTime: aCollection fourth.
]

{ #category : #accessing }
GTAComputerBookmark >> path [
	^ Array
		with: self class
		with: self item computerUUID
		with: self description
		with: self dateAndTime
]
