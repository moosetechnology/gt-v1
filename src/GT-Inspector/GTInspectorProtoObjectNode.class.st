"
I am a variable node for representing the slots of objects that subclass ProtoObject directly and not Object. My main responsability is to extract the value of a slot using thisContext and not a direct message send to the object.  I used the name of a slot as a key.
"
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
