Class {
	#name : #GTEventRecorderFileStorage,
	#superclass : #Object,
	#instVars : [
		'directory'
	],
	#category : #'GT-EventRecorder-Server-Core'
}

{ #category : #'as yet unclassified' }
GTEventRecorderFileStorage >> atCategory: aString put: aByteArray [
	| subDirectory date monthDirectoryName monthDirectory fileName file |
	subDirectory := (self directory / aString) ensureCreateDirectory; yourself.
	date := Date today.
	monthDirectoryName := date year printString, (date month index printStringBase: 10 nDigits: 2).
	monthDirectory := subDirectory / monthDirectoryName.
	monthDirectory ensureCreateDirectory.
	fileName := UUID new printString.
	file := monthDirectory / fileName.
	file exists ifTrue: [ 
		fileName := fileName, '-time-', DateAndTime now asUnixTime printString.
		file := monthDirectory / fileName ].
	file ensureDelete.
	file writeStreamDo: [ :aStream | aStream nextPutAll: aByteArray ].
	^ aString, '/', monthDirectoryName, '/', fileName
]

{ #category : #accessing }
GTEventRecorderFileStorage >> directory [
	^ directory
]

{ #category : #accessing }
GTEventRecorderFileStorage >> directory: anObject [
	directory := anObject
]

{ #category : #'as yet unclassified' }
GTEventRecorderFileStorage >> put: aByteArray [
	^ self atCategory: #unspecified put: aByteArray
]
