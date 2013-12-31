Class {
	#name : #ACDStackSetReceiver,
	#superclass : #DebugAction,
	#category : #'ACD-Glamour-Interface'
}

{ #category : #'as yet unclassified' }
ACDStackSetReceiver >> appliesToDebugger: aDebugger [
	"Only a context above the sender context can be selected as the receiver"
	
	^ (aDebugger selectedStackContext findContextSuchThat: [ :aContext |
		(aContext == aDebugger session senderContext) ]) isNil
]

{ #category : #'as yet unclassified' }
ACDStackSetReceiver >> defaultLabel [

	^ 'Set as receiver'
]

{ #category : #'as yet unclassified' }
ACDStackSetReceiver >> defaultOrder [

	^ 200
]

{ #category : #'as yet unclassified' }
ACDStackSetReceiver >> executeAction [

	self session updateReceiverFrom: self debugger selectedStackContext
]

{ #category : #'as yet unclassified' }
ACDStackSetReceiver >> id [

	^ #gtSetAsReceiverDebuggerAction
]
