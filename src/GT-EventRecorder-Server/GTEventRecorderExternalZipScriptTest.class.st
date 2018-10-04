"
A GTEventRecorderExternalZipScriptTest is a test class for testing the behavior of GTEventRecorderExternalZipScript
"
Class {
	#name : #GTEventRecorderExternalZipScriptTest,
	#superclass : #TestCase,
	#category : #'GT-EventRecorder-Server-Tests'
}

{ #category : #tests }
GTEventRecorderExternalZipScriptTest >> testSystem [
	| result |
	result := GTEventRecorderExternalZipScript new system: 'ls .'.
	self assert: result isZero.
]

{ #category : #tests }
GTEventRecorderExternalZipScriptTest >> testSystem2 [
	"Calling a command incorrectly"
	| result |
	result := GTEventRecorderExternalZipScript new system: 'ls --non-existent-parameter'.
	self deny: result isZero.
]

{ #category : #tests }
GTEventRecorderExternalZipScriptTest >> testSystem3 [
	"Calling a non existent command"
	| result |
	result := GTEventRecorderExternalZipScript new system: 'non-existent-command'.
	self deny: result isZero.
]
