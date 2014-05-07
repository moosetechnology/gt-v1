Class {
	#name : #GTDebugSelectionDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTDebugSelectionDebugAction class >> gtActionFor: aDebugger [
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
]

{ #category : #'as yet unclassified' }
GTDebugSelectionDebugAction >> defaultKeyText [

	^ nil
	"^ 'D'"
]

{ #category : #'as yet unclassified' }
GTDebugSelectionDebugAction >> defaultLabel [

	^ 'Debug it'
]

{ #category : #'as yet unclassified' }
GTDebugSelectionDebugAction >> defaultOrder [

	^ 20
]

{ #category : #'as yet unclassified' }
GTDebugSelectionDebugAction >> executeAction [
	
	self debugger codePresentation debugSelection
		

]

{ #category : #'as yet unclassified' }
GTDebugSelectionDebugAction >> id [

	^ #gTDebugSelectionDebugAction
]

{ #category : #'as yet unclassified' }
GTDebugSelectionDebugAction >> initialize [

	self needsUpdate: false
]
