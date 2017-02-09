Class {
	#name : #GTInspectorProtoObjectNode,
	#superclass : #GTInspectorVariableNode,
	#instVars : [
		'index',
		'value',
		'slotName'
	],
	#category : #'GT-Inspector'
}

{ #category : #'instance creation' }
GTInspectorProtoObjectNode class >> hostObject: anObject index: index slotName: aSlotName [
	^ (self hostObject: anObject)
		index: index slotName: aSlotName;
		yourself
]

{ #category : #accessing }
GTInspectorProtoObjectNode >> index: anIndex slotName: aSlotName [
	index := anIndex.
	slotName := aSlotName.
	value := thisContext object: self hostObject instVarAt: anIndex
]

{ #category : #accessing }
GTInspectorProtoObjectNode >> key [
	^ slotName
]

{ #category : #accessing }
GTInspectorProtoObjectNode >> value [ 
	^ value 
]
