Class {
	#name : #GTExecuteSelectionDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction class >> gtActionFor: aDebugger [
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousSpawn
]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> defaultKeyText [

	^ 'd'
]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> defaultLabel [

	^ 'Do it'
]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> defaultOrder [

	^ 10
]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> executeAction [
	
	self debugger codePresentation selectLine.
	self debugger
		evaluate: self debugger codePresentation selectedText 
		in: self currentContext 
		notifying: self
		andDo: [ :result | ] 
		

]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> id [

	^ #gTExecuteSelectionDebugAction
]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> initialize [

	self needsUpdate: false
]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> notify: aString at: anInteger in: aStream [
	
	self codePresentation notify: aString at: anInteger in: aStream
]
