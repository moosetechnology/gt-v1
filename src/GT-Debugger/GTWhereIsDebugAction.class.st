Class {
	#name : #GTWhereIsDebugAction,
	#superclass : #WhereIsDebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTWhereIsDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousSearch
]

{ #category : #accessing }
GTWhereIsDebugAction >> defaultOrder [

	^ 200
]

{ #category : #actions }
GTWhereIsDebugAction >> executeAction [

	self debugger updateSelectionInterval
]

{ #category : #accessing }
GTWhereIsDebugAction >> id [

	^ #gtWhereIs
]
