Class {
	#name : #GTDebugSelectionDebugAction,
	#superclass : #GTCodeDebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTDebugSelectionDebugAction class >> gtActionFor: aDebugger [
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
]

{ #category : #accessing }
GTDebugSelectionDebugAction >> defaultKeyText [

	^ nil
	"^ 'D'"
]

{ #category : #accessing }
GTDebugSelectionDebugAction >> defaultLabel [

	^ 'Debug it'
]

{ #category : #accessing }
GTDebugSelectionDebugAction >> defaultOrder [

	^ 20
]

{ #category : #actions }
GTDebugSelectionDebugAction >> executeAction [
	
	self codePresentation debugSelection
		

]

{ #category : #accessing }
GTDebugSelectionDebugAction >> id [

	^ #gTDebugSelectionDebugAction
]

{ #category : #initialization }
GTDebugSelectionDebugAction >> initialize [
	super initialize.
	self needsUpdate: false
]
