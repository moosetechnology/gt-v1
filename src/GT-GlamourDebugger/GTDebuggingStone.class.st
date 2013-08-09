Class {
	#name : #GTDebuggingStone,
	#superclass : #Object,
	#instVars : [
		'pragma',
		'session'
	],
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTDebuggingStone class >> forPragma: aPragma forSession: aSession [

	^ self new forPragma: aPragma forSession: aSession
]

{ #category : #'as yet unclassified' }
GTDebuggingStone >> activeSelector [

	^ pragma argumentAt: 3
]

{ #category : #'as yet unclassified' }
GTDebuggingStone >> forPragma: aPragma forSession: aSession [
	
	pragma := aPragma.
	session := aSession
]

{ #category : #'as yet unclassified' }
GTDebuggingStone >> isActive [

	^ self perform: self activeSelector
]

{ #category : #'as yet unclassified' }
GTDebuggingStone >> nextActionSelector [

	^ pragma argumentAt: 4
]

{ #category : #'as yet unclassified' }
GTDebuggingStone >> pass [

	^ true
]

{ #category : #'as yet unclassified' }
GTDebuggingStone >> reachDestinationFromContext: aContext [

	^ self perform: self nextActionSelector withEnoughArguments: (Array with: aContext)
]

{ #category : #'as yet unclassified' }
GTDebuggingStone >> reachedTarget [

	^ (self class canUnderstand: self tagetSelector) 	
		ifFalse: [ true ]
		ifTrue: [ self perform: self tagetSelector ]
]

{ #category : #'as yet unclassified' }
GTDebuggingStone >> session [

	^ session
]

{ #category : #'as yet unclassified' }
GTDebuggingStone >> tagetSelector [

	^ 'has', (pragma argumentAt: 3) capitalized, 'ReachedTarget'
]
