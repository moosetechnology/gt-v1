Class {
	#name : #GTBrowseDebugAction,
	#superclass : #BrowseDebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #'actions creation' }
GTBrowseDebugAction class >> gtDebugActionsFor: aDebugger [
	<gtContextStackDebuggingAction>
	
	^ super debugActionsFor: aDebugger
]

{ #category : #accessing }
GTBrowseDebugAction >> receiver [

	^ self debugger
]
