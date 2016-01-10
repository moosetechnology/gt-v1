"
This debugger action is responsible for saving the current method from a debugger.
"
Class {
	#name : #GTSaveDebugAction,
	#superclass : #GTCodeDebugAction,
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

	^ 260
]

{ #category : #actions }
GTSaveDebugAction >> executeAction [

	self needsUpdate: false.
	self codePresentation
		compileTextIn: self currentContext from: self session andDo: [ self needsUpdate: true ]

	"self session 
		recompileMethodTo: sourceCode 
		inContext: self currentContext 
		notifying: self debugger codePresentation"
]

{ #category : #accessing }
GTSaveDebugAction >> id [

	^ #gTSaveDebugAction
]
