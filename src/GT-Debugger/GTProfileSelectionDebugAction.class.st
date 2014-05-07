Class {
	#name : #GTProfileSelectionDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTProfileSelectionDebugAction class >> gtActionFor: aDebugger [
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
]

{ #category : #'as yet unclassified' }
GTProfileSelectionDebugAction >> defaultLabel [

	^ 'Profile it'
]

{ #category : #'as yet unclassified' }
GTProfileSelectionDebugAction >> defaultOrder [

	^ 30
]

{ #category : #'as yet unclassified' }
GTProfileSelectionDebugAction >> executeAction [
	
	self debugger codePresentation profileSelection
		

]

{ #category : #'as yet unclassified' }
GTProfileSelectionDebugAction >> id [

	^ #gTProfileSelectionDebugAction
]

{ #category : #'as yet unclassified' }
GTProfileSelectionDebugAction >> initialize [

	self needsUpdate: false
]
