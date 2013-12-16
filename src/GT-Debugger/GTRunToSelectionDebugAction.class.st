Class {
	#name : #GTRunToSelectionDebugAction,
	#superclass : #RunToSelectionDebugAction,
	#category : #'GT-Debugger'
}

{ #category : #registration }
GTRunToSelectionDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousPlay
]

{ #category : #actions }
GTRunToSelectionDebugAction >> executeAction [

	self session 
		runToSelection: self debugger selectionInterval
		inContext: self currentContext
]

{ #category : #accessing }
GTRunToSelectionDebugAction >> id [

	^ #gtRunToSelection
]
