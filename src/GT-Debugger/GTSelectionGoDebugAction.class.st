Class {
	#name : #GTSelectionGoDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTSelectionGoDebugAction class >> gtActionFor: aDebugger [
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
]

{ #category : #accessing }
GTSelectionGoDebugAction >> defaultKeyText [

	^ 'g'
]

{ #category : #accessing }
GTSelectionGoDebugAction >> defaultLabel [

	^ 'Do it and go'
]

{ #category : #accessing }
GTSelectionGoDebugAction >> defaultOrder [

	^ 5
]

{ #category : #actions }
GTSelectionGoDebugAction >> executeAction [
	
	self debugger codePresentation evaluateSelectionAndDo: [ :result | self debugger inspect: result ] 
		

]

{ #category : #accessing }
GTSelectionGoDebugAction >> id [

	^ #gTOpenSelectionDebugAction
]

{ #category : #initialization }
GTSelectionGoDebugAction >> initialize [

	self needsUpdate: false
]
