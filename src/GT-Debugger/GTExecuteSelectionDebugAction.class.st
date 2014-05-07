Class {
	#name : #GTExecuteSelectionDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
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

	^ 15
]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> executeAction [
	
	self debugger codePresentation evaluateSelection
		

]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> id [

	^ #gTExecuteSelectionDebugAction
]

{ #category : #'as yet unclassified' }
GTExecuteSelectionDebugAction >> initialize [

	self needsUpdate: false
]
