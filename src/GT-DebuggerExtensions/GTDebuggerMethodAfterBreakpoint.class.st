Class {
	#name : #GTDebuggerMethodAfterBreakpoint,
	#superclass : #GTDebuggerBrekpoint,
	#instVars : [
		'targetMethod'
	],
	#category : #'GT-DebuggerExtensions'
}

{ #category : #actions }
GTDebuggerMethodAfterBreakpoint >> install [

	self metaLink: (MetaLink new
		metaObject: self;
		selector: #breakpointReached;
		condition: condition arguments: conditionArguments;
		control: #after).
	targetMethod ast link: self metaLink.

]

{ #category : #accessing }
GTDebuggerMethodAfterBreakpoint >> instrumentationContextFrom: aContext [

	^ (super instrumentationContextFrom: aContext) sender
]

{ #category : #accessing }
GTDebuggerMethodAfterBreakpoint >> targetMethod [
	^ targetMethod
]

{ #category : #accessing }
GTDebuggerMethodAfterBreakpoint >> targetMethod: anObject [
	targetMethod := anObject
]

{ #category : #actions }
GTDebuggerMethodAfterBreakpoint >> updateDebuggingSession: aSession [
	super updateDebuggingSession: aSession.
	
	"aSession stepInto."
	
	"aSession updateContextTo: aSession interruptedContext sender"
]
