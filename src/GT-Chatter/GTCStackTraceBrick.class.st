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
	^ self message title ifNil: [ 'Click to debug stack trace' ]
]
