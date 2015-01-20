Class {
	#name : #GTClearEditorDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTClearEditorDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		icon: GLMUIThemeExtraIcons glamorousCancel
]

{ #category : #accessing }
GTClearEditorDebugAction >> defaultIcon [

	^ nil
	"^ Smalltalk ui icons smallCancelIcon"
]

{ #category : #accessing }
GTClearEditorDebugAction >> defaultKeyText [

	^ 'l'
]

{ #category : #accessing }
GTClearEditorDebugAction >> defaultLabel [

	^ 'Cancel'
]

{ #category : #accessing }
GTClearEditorDebugAction >> defaultOrder [

	^ 10
]

{ #category : #actions }
GTClearEditorDebugAction >> executeAction [

	(self confirm:
'This action will cancel your changes.
Is it OK to cancel changes?' translated) ifTrue: [ self debugger updateBrowser]
]

{ #category : #accessing }
GTClearEditorDebugAction >> id [

	^ #gtClearEditorDebugAction
]

{ #category : #initialization }
GTClearEditorDebugAction >> initialize [

	self needsUpdate: false
]
