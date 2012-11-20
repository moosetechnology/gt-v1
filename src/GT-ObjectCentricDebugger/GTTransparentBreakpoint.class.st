Class {
	#name : #GTTransparentBreakpoint,
	#superclass : #Halt,
	#instVars : [
		'receiver'
	],
	#category : #'GT-ObjectCentricDebugger'
}

{ #category : #'as yet unclassified' }
GTTransparentBreakpoint class >> signalAndNotify: anObject [

	^ self new signalAndNotify: anObject 
]

{ #category : #'as yet unclassified' }
GTTransparentBreakpoint >> defaultAction [ 	
	Transcript crShow: 'GTTransparentBreakpoint>>defaultAction activeProcess: ', Processor activeProcess name.
	
	receiver resetDebuggerWithContext: self signalerContext fromProcess:  Processor activeProcess.
]

{ #category : #'as yet unclassified' }
GTTransparentBreakpoint >> signalAndNotify: anObject [

	receiver := anObject.
	super signal.
]
