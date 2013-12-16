Class {
	#name : #GTClearEditorDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-Debugger'
}

{ #category : #registration }
GTClearEditorDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	<gtContextCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
]

{ #category : #'as yet unclassified' }
GTClearEditorDebugAction >> defaultIcon [

	^ nil
	"^ Smalltalk ui icons smallCancelIcon"
]

{ #category : #'as yet unclassified' }
GTClearEditorDebugAction >> defaultKeyText [

	^ 'l'
]

{ #category : #'as yet unclassified' }
GTClearEditorDebugAction >> defaultLabel [

	^ 'Cancel'
]

{ #category : #'as yet unclassified' }
GTClearEditorDebugAction >> defaultOrder [

	^ 10
]

{ #category : #'as yet unclassified' }
GTClearEditorDebugAction >> executeAction [

	(self confirm:
'This action will cancel your changes.
Is it OK to cancel changes?' translated) ifTrue: [ self debugger updateBrowser]
]

{ #category : #'as yet unclassified' }
GTClearEditorDebugAction >> id [

	^ #gtClearEditorDebugAction
]

{ #category : #'as yet unclassified' }
GTClearEditorDebugAction >> initialize [

	self needsUpdate: false
]
