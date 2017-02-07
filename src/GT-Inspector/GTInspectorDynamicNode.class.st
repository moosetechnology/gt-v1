Class {
	#name : #GTInspectorDynamicNode,
	#superclass : #GTInspectorVariableNode,
	#instVars : [
		'label',
		'value'
	],
	#category : #'GT-Inspector'
}

{ #category : #'instance creation' }
GTInspectorDynamicNode class >> hostObject: anObject label: aString value: anotherObject [
	^ (self hostObject: anObject) 
		label: aString;
		value: anotherObject
]

{ #category : #accessing }
GTInspectorDynamicNode >> key [
	^ label
]

{ #category : #accessing }
GTInspectorDynamicNode >> label [
	^ label
]

{ #category : #accessing }
GTInspectorDynamicNode >> label: aString [
	label := aString
]

{ #category : #accessing }
GTInspectorDynamicNode >> value [
	^ value
]

{ #category : #accessing }
GTInspectorDynamicNode >> value: anObject [
	value := anObject
]
