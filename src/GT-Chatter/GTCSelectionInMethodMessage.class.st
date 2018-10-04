Class {
	#name : #GTCSelectionInMethodMessage,
	#superclass : #GTCAddressedMessage,
	#instVars : [
		'ring',
		'selection'
	],
	#category : #'GT-Chatter-RemoteAnnouncements'
}

{ #category : #converting }
GTCSelectionInMethodMessage >> asMessageMorph [
	^ GTCSelectionInMethodMessageBrick new
			message: self;
			yourself
]

{ #category : #accessing }
GTCSelectionInMethodMessage >> ring [
	^ ring
]

{ #category : #accessing }
GTCSelectionInMethodMessage >> ring: anObject [
	ring := anObject
]

{ #category : #accessing }
GTCSelectionInMethodMessage >> ringClass [
	^ self ring ringClass
]

{ #category : #accessing }
GTCSelectionInMethodMessage >> selection [
	^ selection
]

{ #category : #accessing }
GTCSelectionInMethodMessage >> selection: anObject [
	selection := anObject
]
