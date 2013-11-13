Class {
	#name : #GTWhereIsDebugAction,
	#superclass : #WhereIsDebugAction,
	#category : #'GT-Debugger'
}

{ #category : #registration }
GTWhereIsDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousSearch
]

{ #category : #actions }
GTWhereIsDebugAction >> executeAction [

	self debugger updateSelectionInterval
]

{ #category : #accessing }
GTWhereIsDebugAction >> id [

	^ #gtWhereIs
]
