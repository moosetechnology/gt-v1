Class {
	#name : #GTObjectCentricProxyDebugger,
	#superclass : #GTProxyDebugger,
	#category : #'GT-Debugger-ObjectCentric'
}

{ #category : #'as yet unclassified' }
GTObjectCentricProxyDebugger class >> initialize [
	super initialize.

	"Add ourselves to registry. See [Smalltalk tools]" 
	Smalltalk tools register: self as: #debugger
]

{ #category : #accessing }
GTObjectCentricProxyDebugger >> debuggerClass [
	^ GTObjectCentricDebugger
]
