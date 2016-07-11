Class {
	#name : #GTAbstractExampleAnnouncement,
	#superclass : #Announcement,
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTAbstractExampleAnnouncement class >> isAbstract [
	^ self == GTAbstractExampleAnnouncement
]

{ #category : #testing }
GTAbstractExampleAnnouncement >> isAbstract [
	^ self class isAbstract
]
