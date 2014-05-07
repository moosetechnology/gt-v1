Class {
	#name : #GTInspectSelectionDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTInspectSelectionDebugAction class >> gtActionFor: aDebugger [
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousInspect
]

{ #category : #'as yet unclassified' }
GTInspectSelectionDebugAction >> defaultKeyText [

	^ 'i'
]

{ #category : #'as yet unclassified' }
GTInspectSelectionDebugAction >> defaultLabel [

	^ 'Inspect it'
]

{ #category : #'as yet unclassified' }
GTInspectSelectionDebugAction >> defaultOrder [

	^ 15
]

{ #category : #'as yet unclassified' }
GTInspectSelectionDebugAction >> executeAction [
	
	self debugger codePresentation evaluateSelectionAndDo: [ :result | result inspect ]
		

]

{ #category : #'as yet unclassified' }
GTInspectSelectionDebugAction >> id [

	^ #gTInspectSelectionDebugAction
]

{ #category : #'as yet unclassified' }
GTInspectSelectionDebugAction >> initialize [

	self needsUpdate: false
]
