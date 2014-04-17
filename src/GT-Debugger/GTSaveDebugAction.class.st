Class {
	#name : #GTSaveDebugAction,
	#superclass : #DebugAction,
	#instVars : [
		'sourceCode'
	],
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTSaveDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousAccept
]

{ #category : #'as yet unclassified' }
GTSaveDebugAction >> asGlamourAction [

	^ super asGlamourAction
			shortcut: $s;
			action: [ :textPresentation |
				self sourceCode: textPresentation text.
				self execute ]
]

{ #category : #initialization }
GTSaveDebugAction >> defaultLabel [

	^ 'Accept'
]

{ #category : #initialization }
GTSaveDebugAction >> defaultOrder [

	^ 5
]

{ #category : #actions }
GTSaveDebugAction >> executeAction [

	self session 
		recompileMethodTo: sourceCode 
		inContext: self currentContext 
		notifying: self debugger codePresentation
]

{ #category : #accessing }
GTSaveDebugAction >> sourceCode: aText [

	sourceCode := aText
]
