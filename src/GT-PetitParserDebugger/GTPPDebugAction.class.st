Class {
	#name : #GTPPDebugAction,
	#superclass : #DebugAction,
	#instVars : [
		'startContext'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #testing }
GTPPDebugAction >> appliesToContext: aContext [

	^ self session isActive and: [
		aContext locateRootPPParser notNil ]
]

{ #category : #accessing }
GTPPDebugAction >> startContext [

	^ startContext ifNil: [ self currentContext ]
]

{ #category : #accessing }
GTPPDebugAction >> startContext: aContext [

	startContext := aContext
]
