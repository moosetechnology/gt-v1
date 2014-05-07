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

	^ 5
]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> executeAction [
	
	self debugger codePresentation evaluateSelectionAndDo: [ :result | self debugger inspect: result ] 
		

]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> id [

	^ #gTOpenSelectionDebugAction
]

{ #category : #'as yet unclassified' }
GTOpenSelectionDebugAction >> initialize [

	self needsUpdate: false
]
