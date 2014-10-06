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

{ #category : #'as yet unclassified' }
GTSelectionGoDebugAction >> defaultKeyText [

	^ 'g'
]

{ #category : #'as yet unclassified' }
GTSelectionGoDebugAction >> defaultLabel [

	^ 'Do it and go'
]

{ #category : #'as yet unclassified' }
GTSelectionGoDebugAction >> defaultOrder [

	^ 5
]

{ #category : #'as yet unclassified' }
GTSelectionGoDebugAction >> executeAction [
	
	self debugger codePresentation evaluateSelectionAndDo: [ :result | self debugger inspect: result ] 
		

]

{ #category : #'as yet unclassified' }
GTSelectionGoDebugAction >> id [

	^ #gTOpenSelectionDebugAction
]

{ #category : #'as yet unclassified' }
GTSelectionGoDebugAction >> initialize [

	self needsUpdate: false
]
