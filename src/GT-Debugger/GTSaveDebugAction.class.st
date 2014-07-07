Class {
	#name : #GTSaveDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTSaveDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousAccept
]

{ #category : #accessing }
GTSaveDebugAction >> defaultKeyText [

	^ 's'
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

	self needsUpdate: false.
	self debugger codePresentation 
		compileTextIn: self currentContext from: self session andDo: [ self needsUpdate: true ]

	"self session 
		recompileMethodTo: sourceCode 
		inContext: self currentContext 
		notifying: self debugger codePresentation"
]
