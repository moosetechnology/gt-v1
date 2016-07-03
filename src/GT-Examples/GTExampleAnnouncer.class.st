Class {
	#name : #GTExampleAnnouncer,
	#superclass : #Announcer,
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Examples-Announcements'
}

{ #category : #public }
GTExampleAnnouncer class >> instance [
	^ instance ifNil: [ instance := self basicNew initialize ]
]
