Class {
	#name : #GTInspectorSlotNode,
	#superclass : #GTInspectorVariableNode,
	#instVars : [
		'slot',
		'value'
	],
	#category : #'GT-Inspector'
}

{ #category : #'instance creation' }
GTInspectorSlotNode class >> hostObject: anObject slot: aSlot [
	^ (self hostObject: anObject)
		slot: aSlot;
		yourself
]

{ #category : #accessing }
GTInspectorSlotNode >> browsingActionsForNode [

	^ {
			GLMGenericAction new 
				action: [ self systemNavigation browseAllAccessesTo: self label from: self hostObject class ]; 
				title: 'List methods using this variable'.
			GLMGenericAction new 
				action: [ self systemNavigation browseAllStoresInto: self label from: self hostObject class ]; 
				title: 'List methods storing into this variable'.		
		}
]

{ #category : #accessing }
GTInspectorSlotNode >> editingActionForNode [

	^ GLMGenericAction new 
		action: [ self inform: 'To be implemented' ]; 
		title: 'Edit value'
]

{ #category : #accessing }
GTInspectorSlotNode >> inspectorActionsForNode [
	"Return a collection of available inspector actions associated with a variable node"
	<return: #Collection of: #GLMAction>

	^ 
		{ self editingActionForNode },
		self browsingActionsForNode
]

{ #category : #accessing }
GTInspectorSlotNode >> key [
	^ self slot name
]

{ #category : #accessing }
GTInspectorSlotNode >> slot [
	^ slot
]

{ #category : #accessing }
GTInspectorSlotNode >> slot: aSlot [

	self
		assert: [ aSlot isNotNil ]
		description: [ 'Slot can not be nil' ].

	slot := aSlot.
	value := self hostObject readSlot: slot
]

{ #category : #accessing }
GTInspectorSlotNode >> value [
	^ value
]
