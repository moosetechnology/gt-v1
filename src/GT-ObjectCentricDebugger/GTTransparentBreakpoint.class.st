Class {
	#name : #GTTransparentBreakpoint,
	#superclass : #Halt,
	#instVars : [
		'receivers'
	],
	#category : #'GT-ObjectCentricDebugger'
}

{ #category : #'as yet unclassified' }
GTTransparentBreakpoint class >> signalAndNotify: aWeakCollection [

	^ self new signalAndNotify: aWeakCollection 
]

{ #category : #'as yet unclassified' }
GTTransparentBreakpoint >> defaultAction [ 	
	Transcript crShow: 'GTTransparentBreakpoint>>defaultAction activeProcess: ', Processor activeProcess name.
	
	receivers do: [:each| 
		Transcript crShow: 'GTTransparentBreakpoint>>defaultAction each ', each class name.
		each resetDebuggerWithContext: self signalerContext fromProcess:  Processor activeProcess].
]

{ #category : #'as yet unclassified' }
GTTransparentBreakpoint >> signalAndNotify: aWeakCollection [

	receivers := aWeakCollection.
	super signal.
]
