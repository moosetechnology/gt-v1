Class {
	#name : #ACDStackSetSender,
	#superclass : #DebugAction,
	#category : #'ACD-Glamour-Interface'
}

{ #category : #'as yet unclassified' }
ACDStackSetSender class >> gtACDSenderActionFor: aDebugger [
	<gtContextACDStackDebuggingAction>
]

{ #category : #'as yet unclassified' }
ACDStackSetSender >> appliesToDebugger: aDebugger [
	"Only a context bellow the receiver context can be selected as the sender"
	
	^ (aDebugger selectedStackContext findContextSuchThat: [ :aSenderContext |
		(aSenderContext == aDebugger session receiverContext) ]) isNil
]

{ #category : #'as yet unclassified' }
ACDStackSetSender >> defaultLabel [

	^ 'Set as sender'
]

{ #category : #'as yet unclassified' }
ACDStackSetSender >> defaultOrder [

	^ 205
]

{ #category : #'as yet unclassified' }
ACDStackSetSender >> executeAction [

	self session updateSenderFrom: self debugger selectedStackContext
]

{ #category : #'as yet unclassified' }
ACDStackSetSender >> id [

	^ #gtSetAsSenderDebuggerAction
]
