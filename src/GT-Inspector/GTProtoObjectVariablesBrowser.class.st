"
This is a specialization that works with ProtoObject and all its subclasses that except for Object that has its own specialization.

Example:
self openOn: ProtoObject new
"
Class {
	#name : #GTProtoObjectVariablesBrowser,
	#superclass : #GTRawObjectVariablesBrowser,
	#category : #'GT-Inspector'
}

{ #category : #'private building' }
GTProtoObjectVariablesBrowser >> basicVariableValuePairsFor: anObject [

	^ (anObject class allInstVarNames 
			collectWithIndex: [ :ivName :index | 
				ivName -> (thisContext object: anObject instVarAt: index) ]) 
					sort
			
]

{ #category : #'private building' }
GTProtoObjectVariablesBrowser >> printStringOf: anObject [
	| className |
	className := anObject class name.
	^ (String streamContents: [ :s |
		s
			nextPutAll: (className first isVowel ifTrue: ['an '] ifFalse: ['a ']);
			nextPutAll: className ]) asComment
]
