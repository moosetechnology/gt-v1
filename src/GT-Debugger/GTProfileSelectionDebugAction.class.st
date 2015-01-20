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

{ #category : #accessing }
GTProfileSelectionDebugAction >> defaultLabel [

	^ 'Profile it'
]

{ #category : #accessing }
GTProfileSelectionDebugAction >> defaultOrder [

	^ 30
]

{ #category : #actions }
GTProfileSelectionDebugAction >> executeAction [
	
	self debugger codePresentation profileSelection
		

]

{ #category : #accessing }
GTProfileSelectionDebugAction >> id [

	^ #gTProfileSelectionDebugAction
]

{ #category : #initialization }
GTProfileSelectionDebugAction >> initialize [

	self needsUpdate: false
]
