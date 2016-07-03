Class {
	#name : #GTExampleModified,
	#superclass : #GTExampleAnnouncement,
	#instVars : [
		'oldExample'
	],
	#category : #'GT-Examples-DEPRECATED'
}

{ #category : #accessing }
GTExampleModified >> oldExample [
	^ oldExample
]

{ #category : #accessing }
GTExampleModified >> oldExample: anObject [
	oldExample := anObject
]
