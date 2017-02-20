"
I am a variable node for representing the indexed variables of an object. I used the index of a variable as a key.
"
Class {
	#name : #GTInspectorIndexedNode,
	#superclass : #GTInspectorVariableNode,
	#instVars : [
		'index',
		'value'
	],
	#category : #'GT-Inspector'
}

{ #category : #'instance creation' }
GTInspectorIndexedNode class >> hostObject: anObject index: index [
	^ (self hostObject: anObject)
		index: index;
		yourself
]

{ #category : #accessing }
GTInspectorIndexedNode >> index [
	^ index
]

{ #category : #accessing }
GTInspectorIndexedNode >> index: anInteger [
	index := anInteger.
	value := self hostObject basicAt: index
]

{ #category : #accessing }
GTInspectorIndexedNode >> key [
	^ self index
]

{ #category : #accessing }
GTInspectorIndexedNode >> value [
	^ value
]
