Class {
	#name : #GTExampleModified,
	#superclass : #GTExampleAnnouncement,
	#instVars : [
		'oldExample'
	],
	#category : #'GT-Inspector-Examples-Announcements'
}

{ #category : #accessing }
GTExampleModified >> oldExample [
	^ oldExample
]

{ #category : #accessing }
GTExampleModified >> oldExample: anObject [
	oldExample := anObject
]
