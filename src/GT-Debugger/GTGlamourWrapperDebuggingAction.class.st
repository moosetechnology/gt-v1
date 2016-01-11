"
I simply wrap an existing glamour action. Currently I just return the action when one send #asGlamourAction.
"
Class {
	#name : #GTGlamourWrapperDebuggingAction,
	#superclass : #DebugAction,
	#instVars : [
		'glamourAction'
	],
	#category : #'GT-Debugger-Actions'
}

{ #category : #registration }
GTGlamourWrapperDebuggingAction class >> gtActionFor: aDebugger [
	<gtContextCodeDebuggingAction>
	|index|
	
	index := 0.
	^ aDebugger codePresentation defaultSelectionActions collect: [ :each | 
			self new 
				glamourAction: each;
				order: (index := index + 5) ]
]

{ #category : #transformation }
GTGlamourWrapperDebuggingAction >> asGlamourAction [
	^ glamourAction
]

{ #category : #accessing }
GTGlamourWrapperDebuggingAction >> glamourAction: anObject [
	glamourAction := anObject.
]
