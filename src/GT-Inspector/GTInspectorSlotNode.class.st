Class {
	#name : #GTInspectorSlotNode,
	#superclass : #GTInspectorVariableNode,
	#instVars : [
		'slotName',
		'value'
	],
	#category : #'GT-Inspector'
}

{ #category : #'as yet unclassified' }
GTInspectorSlotNode class >> hostObject: anObject slotName: aString [
	^ (self hostObject: anObject) slotName: aString
]

{ #category : #accessing }
GTInspectorSlotNode >> browsingActionsForNode [
	^ {
			GLMGenericAction new 
				action: [ self systemNavigation browseAllAccessesTo: self label from: self hostObject class ]; 
				title: 'List methods using this variable'.
			GLMGenericAction new 
				action: [:list | self systemNavigation browseAllStoresInto: self label from: self hostObject class ]; 
				title: 'List methods storing into this variable'.		
		}
]

{ #category : #accessing }
GTInspectorSlotNode >> editingActionForNode [

	^ GLMGenericAction new 
		action: [ :currentPresentation | self inform: 'To be implemented' ]; 
		title: 'Edit value'
]

{ #category : #accessing }
GTInspectorSlotNode >> inspectorActionsForNode [
	^ 
		{ self editingActionForNode },
		self browsingActionsForNode
]

{ #category : #accessing }
GTInspectorSlotNode >> key [
	^ self slotName
]

{ #category : #accessing }
GTInspectorSlotNode >> slotName [
	^ slotName
]

{ #category : #accessing }
GTInspectorSlotNode >> slotName: aString [
	slotName := aString.
	value := self hostObject readSlotNamed: slotName
]

{ #category : #accessing }
GTInspectorSlotNode >> value [
	^ value
]
