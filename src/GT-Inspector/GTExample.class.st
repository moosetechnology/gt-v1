"
This encapsulates one example.
"
Class {
	#name : #GTExample,
	#superclass : #Object,
	#instVars : [
		'methodReference',
		'result',
		'name'
	],
	#category : #'GT-Inspector'
}

{ #category : #accessing }
GTExample >> methodReference [
	^ methodReference
]

{ #category : #accessing }
GTExample >> methodReference: anObject [
	methodReference := anObject
]

{ #category : #accessing }
GTExample >> name [
	^ name
]

{ #category : #accessing }
GTExample >> result [
	^ result ifNil: [ result := self methodReference realClass theNonMetaClass perform: self methodReference selector ]
]
