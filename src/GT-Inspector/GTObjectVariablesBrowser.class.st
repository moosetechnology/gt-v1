"
This is a helper browser for the main view in the GTInspector.

Example:
self openOn: Smalltalk
"
Class {
	#name : #GTObjectVariablesBrowser,
	#superclass : #GTRawObjectVariablesBrowser,
	#category : #'GT-Inspector'
}

{ #category : #'private building' }
GTObjectVariablesBrowser >> basicVariableNodesFor: anObject in: aCollection [

	^ anObject gtInspectorVariableNodesIn: aCollection 
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> printStringOf: anObject [
	^ [(anObject printString contractTo: 200) asComment] 
			on: Error 
			do: ['"Error printing. Try self printString to debug"']
]
