Class {
	#name : #GTBrowseDebugAction,
	#superclass : #BrowseDebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #'actions creation' }
GTBrowseDebugAction class >> gtDebugActionsFor: aDebugger [
	<gtContextDebuggingAction>
	
	^ super debugActionsFor: aDebugger
]

{ #category : #accessing }
GTBrowseDebugAction >> receiver [

	^ self debugger
]
