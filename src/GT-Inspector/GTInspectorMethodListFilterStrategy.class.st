Class {
	#name : #GTInspectorMethodListFilterStrategy,
	#superclass : #GTInspectorPresentationFilterStrategy,
	#instVars : [
		'methodSignatures'
	],
	#category : #'GT-Inspector'
}

{ #category : #'as yet unclassified' }
GTInspectorMethodListFilterStrategy >> addMethodSignatureFor: aMethod [

	methodSignatures add: (aMethod selector -> aMethod methodClass)
]

{ #category : #'as yet unclassified' }
GTInspectorMethodListFilterStrategy >> initialize [
	super initialize.
	methodSignatures := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
GTInspectorMethodListFilterStrategy >> shouldDisplayPresentationCreateBy: aMethod [

	^ methodSignatures anySatisfy: [ :aSignature | 
		aSignature key = aMethod selector and: [ aSignature value = aMethod methodClass ] ]
]
