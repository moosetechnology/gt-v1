Class {
	#name : #GTOpenSelectionDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTOpenSelectionDebugAction class >> gtActionFor: aDebugger [
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> defaultKeyText [

	^ 'o'
]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> defaultLabel [

	^ 'Open it'
]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> defaultOrder [

	^ 20
]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> executeAction [
	
	self debugger codePresentation selectLine.
	self debugger
		evaluate: self debugger codePresentation selectedText 
		in: self currentContext 
		notifying: self
		andDo: [ :result | self debugger inspect: result ] 
		

]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> id [

	^ #gTOpenSelectionDebugAction
]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> initialize [

	self needsUpdate: false
]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> notify: aString at: anInteger in: aStream [
	
	self codePresentation notify: aString at: anInteger in: aStream
]
