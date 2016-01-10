"
This action is responsible for inspecting a selected piece of code from the code pane of the debugger.
"
Class {
	#name : #GTInspectSelectionDebugAction,
	#superclass : #GTCodeDebugAction,
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
	
	self codePresentation evaluateSelectionAndDo: [ :result | result inspect ]
		

]

{ #category : #accessing }
GTInspectSelectionDebugAction >> id [

	^ #gTInspectSelectionDebugAction
]

{ #category : #initialization }
GTInspectSelectionDebugAction >> initialize [
	super initialize.
	self needsUpdate: false
]
