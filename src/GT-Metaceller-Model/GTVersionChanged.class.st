Class {
	#name : #GTVersionChanged,
	#superclass : #Announcement,
	#instVars : [
		'version'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTVersionChanged class >> on: aVersion [
	^self new
		version: aVersion;
		yourself
]

{ #category : #accessing }
GTVersionChanged >> version [
	^ version
]

{ #category : #accessing }
GTVersionChanged >> version: anObject [
	version := anObject
]
