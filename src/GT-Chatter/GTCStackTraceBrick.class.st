Class {
	#name : #GTCStackTraceBrick,
	#superclass : #GTCSelectionInMethodMessageBrick,
	#instVars : [
		'action'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #actions }
GTCStackTraceBrick >> browseMethod [
	^ self message ifNotNil: [ :aMessage | aMessage materialize ]
]

{ #category : #actions }
GTCStackTraceBrick >> labelString [
	^ 'Click to debug stack trace'
]
