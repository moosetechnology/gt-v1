Class {
	#name : #GTTemporaryPreDebugChangeDebuggerAction,
	#superclass : #DebugAction,
	#instVars : [
		'preDebugWindow'
	],
	#category : #'GT-Debugger'
}

{ #category : #registration }
GTTemporaryPreDebugChangeDebuggerAction class >> actionType [
	<preDebuggingAction>
]

{ #category : #'as yet unclassified' }
GTTemporaryPreDebugChangeDebuggerAction >> defaultLabel [

	^ 'Debug Glamorously'
]

{ #category : #'as yet unclassified' }
GTTemporaryPreDebugChangeDebuggerAction >> defaultOrder [

	^ 200
]

{ #category : #'as yet unclassified' }
GTTemporaryPreDebugChangeDebuggerAction >> executeAction [
	| currentDebugger currentSession |
	
	"Close the spec PreDebugWindow and debugger"
	currentDebugger := self preDebugWindow debugger.
	self preDebugWindow debugger: nil.
	self preDebugWindow close.
	currentSession := currentDebugger session.
	currentDebugger session: nil.
	currentDebugger close.
	
	GTDebugger debugSession: currentDebugger session
]

{ #category : #'as yet unclassified' }
GTTemporaryPreDebugChangeDebuggerAction >> id [

	^ #gtChangeDebuggerPreDebug
]

{ #category : #'as yet unclassified' }
GTTemporaryPreDebugChangeDebuggerAction >> preDebugWindow [
	
	^ preDebugWindow
]

{ #category : #'as yet unclassified' }
GTTemporaryPreDebugChangeDebuggerAction >> preDebugWindow: anObject [
	
	preDebugWindow := anObject
]
