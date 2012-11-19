Class {
	#name : #GTObjectCentricProxyDebugger,
	#superclass : #GTProxyDebugger,
	#category : #'GT-Debugger-ObjectCentric'
}

{ #category : #'as yet unclassified' }
GTObjectCentricProxyDebugger class >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
GTObjectCentricProxyDebugger >> debuggerClass [
	^ GTObjectCentricDebugger
]
