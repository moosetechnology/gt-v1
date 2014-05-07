Class {
	#name : #GTPrintSelectionDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTPrintSelectionDebugAction class >> gtActionFor: aDebugger [
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		
]

{ #category : #'as yet unclassified' }
GTPrintSelectionDebugAction >> defaultKeyText [

	^ 'p'
]

{ #category : #'as yet unclassified' }
GTPrintSelectionDebugAction >> defaultLabel [

	^ 'Print it'
]

{ #category : #'as yet unclassified' }
GTPrintSelectionDebugAction >> defaultOrder [

	^ 10
]

{ #category : #'as yet unclassified' }
GTPrintSelectionDebugAction >> executeAction [
	
	self debugger codePresentation printSelection
		

]

{ #category : #'as yet unclassified' }
GTPrintSelectionDebugAction >> id [

	^ #gTPrintSelectionDebugAction
]

{ #category : #'as yet unclassified' }
GTPrintSelectionDebugAction >> initialize [

	self needsUpdate: false
]
