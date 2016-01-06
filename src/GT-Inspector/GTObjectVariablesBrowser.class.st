"
This is a specialization that works with Object and all its subclasses.

Example:
self openOn: Smalltalk
"
Class {
	#name : #GTObjectVariablesBrowser,
	#superclass : #GTRawObjectVariablesBrowser,
	#category : #'GT-Inspector'
}

{ #category : #'private building' }
GTObjectVariablesBrowser >> printStringOf: anObject [
	^ [(anObject printString contractTo: 200) asComment] 
			on: Error 
			do: ['"Error printing. Try self printString to debug"']
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> variableValuePairsFor: anObject [

	^ anObject gtInspectorVariableValuePairs asOrderedCollection 
		addFirst: 'self' -> anObject; 
		yourself
]
