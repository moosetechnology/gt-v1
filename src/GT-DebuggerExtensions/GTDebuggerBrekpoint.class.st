Class {
	#name : #GTDebuggerBrekpoint,
	#superclass : #Object,
	#instVars : [
		'metaLink',
		'condition',
		'conditionArguments',
		'targetAction'
	],
	#category : #'GT-DebuggerExtensions'
}

{ #category : #callbacks }
GTDebuggerBrekpoint >> breakpointReached [
	targetAction breakpointReachedFrom: self 
]

{ #category : #actions }
GTDebuggerBrekpoint >> install [
	self subclassResponsibility
]

{ #category : #accessing }
GTDebuggerBrekpoint >> instrumentationContextFrom: aContext [
	|ctxt|
	ctxt := aContext sender sender sender sender sender.
	^ ctxt sender methodClass = ReflectiveMethod 
		ifTrue: [ ctxt sender ]
		ifFalse: [ ctxt ]
]

{ #category : #accessing }
GTDebuggerBrekpoint >> metaLink [
	^ metaLink
]

{ #category : #accessing }
GTDebuggerBrekpoint >> metaLink: anObject [
	metaLink := anObject
]

{ #category : #accessing }
GTDebuggerBrekpoint >> targetAction [
	^ targetAction
]

{ #category : #accessing }
GTDebuggerBrekpoint >> targetAction: anObject [
	targetAction := anObject
]

{ #category : #actions }
GTDebuggerBrekpoint >> uninstall [
	self metaLink uninstall 
]

{ #category : #actions }
GTDebuggerBrekpoint >> updateDebuggingSession: aSession [

]

{ #category : #accessing }
GTDebuggerBrekpoint >> whenReceiver: aBlock [

	condition := aBlock.
	conditionArguments := #(receiver)
]
