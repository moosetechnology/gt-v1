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

{ #category : #accessing }
GTPrintSelectionDebugAction >> defaultKeyText [

	^ 'p'
]

{ #category : #accessing }
GTPrintSelectionDebugAction >> defaultLabel [

	^ 'Print it'
]

{ #category : #accessing }
GTPrintSelectionDebugAction >> defaultOrder [

	^ 10
]

{ #category : #actions }
GTPrintSelectionDebugAction >> executeAction [
	
	self debugger codePresentation printSelection
		

]

{ #category : #accessing }
GTPrintSelectionDebugAction >> id [

	^ #gTPrintSelectionDebugAction
]

{ #category : #initialization }
GTPrintSelectionDebugAction >> initialize [

	self needsUpdate: false
]
