Class {
	#name : #GTSpotterItemActionbarBrick,
	#superclass : #GLMBrick,
	#category : #'GT-Spotter-UI'
}

{ #category : #adding }
GTSpotterItemActionbarBrick >> addActionButton: anActionButton [

	self themer spotterThemer itemActionButtonStyleFor: anActionButton.

	self addBrickBack: anActionButton.
]
