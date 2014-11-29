Class {
	#name : #GTSpotterUIThreadStream,
	#superclass : #Object,
	#instVars : [
		'onAddedSelector',
		'onRemoveSelector',
		'receiver'
	],
	#category : #'GT-Spotter-Utils'
}

{ #category : #'as yet unclassified' }
GTSpotterUIThreadStream >> addObjects: aCollection inProcessor: aProcessor [

	self performSymbol: #addAllCandidates:in: withArguments: { aCollection . aProcessor }
]

{ #category : #'adding/removing' }
GTSpotterUIThreadStream >> addValue: anObject [

	self performSymbol: self onAddedSelector withArguments: { anObject }
]

{ #category : #'adding/removing' }
GTSpotterUIThreadStream >> addValue: firstObject value: secondObject [

	self performSymbol: self onAddedSelector withArguments: { firstObject. secondObject }
]

{ #category : #accessing }
GTSpotterUIThreadStream >> onAddedSelector [
	^ onAddedSelector
]

{ #category : #accessing }
GTSpotterUIThreadStream >> onAddedSelector: anObject [
	onAddedSelector := anObject
]

{ #category : #accessing }
GTSpotterUIThreadStream >> onRemoveSelector [
	^ onRemoveSelector
]

{ #category : #accessing }
GTSpotterUIThreadStream >> onRemoveSelector: anObject [
	onRemoveSelector := anObject
]

{ #category : #performing }
GTSpotterUIThreadStream >> performSymbol: aSymbol withArguments: aCollection [
	"UI manages commands for us"
	Processor yield.
	UIManager default defer: [ self receiver perform: aSymbol withEnoughArguments: aCollection ]
]

{ #category : #accessing }
GTSpotterUIThreadStream >> receiver [
	^ receiver
]

{ #category : #accessing }
GTSpotterUIThreadStream >> receiver: anObject [
	receiver := anObject
]
