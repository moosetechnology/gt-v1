Class {
	#name : #GTPPDebugAction,
	#superclass : #DebugAction,
	#instVars : [
		'startContext'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPDebugAction >> appliesToContext: aContext [

	^ self session isActive and: [
		aContext locateRootPPParser notNil ]
]

{ #category : #accessing }
GTPPDebugAction >> startContext [

	^ startContext ifNil: [ self interruptedContext ]
]

{ #category : #accessing }
GTPPDebugAction >> startContext: aContext [

	startContext := aContext
]
