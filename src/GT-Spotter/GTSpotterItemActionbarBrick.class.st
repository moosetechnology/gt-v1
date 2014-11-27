Class {
	#name : #GTSpotterItemActionbarBrick,
	#superclass : #GLMBrick,
	#category : #'GT-Spotter-UI'
}

{ #category : #adding }
GTSpotterItemActionbarBrick >> addActionButton: anActionButton [

	self theme spotterWidgetThemer itemActionButtonStyleFor: anActionButton.

	self addBrickBack: anActionButton.
]
