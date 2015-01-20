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

{ #category : #accessing }
GTInspectSelectionDebugAction >> defaultKeyText [

	^ 'i'
]

{ #category : #accessing }
GTInspectSelectionDebugAction >> defaultLabel [

	^ 'Inspect it'
]

{ #category : #accessing }
GTInspectSelectionDebugAction >> defaultOrder [

	^ 15
]

{ #category : #actions }
GTInspectSelectionDebugAction >> executeAction [
	
	self debugger codePresentation evaluateSelectionAndDo: [ :result | result inspect ]
		

]

{ #category : #accessing }
GTInspectSelectionDebugAction >> id [

	^ #gTInspectSelectionDebugAction
]

{ #category : #initialization }
GTInspectSelectionDebugAction >> initialize [

	self needsUpdate: false
]
