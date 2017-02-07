Class {
	#name : #GTInspectorVariableNode,
	#superclass : #Object,
	#instVars : [
		'hostObject'
	],
	#category : #'GT-Inspector'
}

{ #category : #'instance creation' }
GTInspectorVariableNode class >> hostObject: anObject [ 
	^ self new
		hostObject: anObject;
		yourself
]

{ #category : #accessing }
GTInspectorVariableNode >> hostObject [
	^ hostObject
]

{ #category : #accessing }
GTInspectorVariableNode >> hostObject: anObject [
	hostObject := anObject
]

{ #category : #actions }
GTInspectorVariableNode >> inspectorActionsForNode [
	^ #()
]

{ #category : #accessing }
GTInspectorVariableNode >> key [
	"Answer the key of this object variable (slot, indexed attribute, computed value)."
	self subclassResponsibility
]

{ #category : #accessing }
GTInspectorVariableNode >> label [
	"Answer the label of this object variable (slot, indexed attribute, computed value)."
	^ self key asString
]

{ #category : #accessing }
GTInspectorVariableNode >> value [
	"Answer the object value of this object variable (slot, indexed attribute, computed value)."
	self subclassResponsibility
]
