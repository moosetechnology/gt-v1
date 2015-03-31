Class {
	#name : #GTSpotterElementWithCategoryCommand,
	#superclass : #GTSpotterAnalysisCommand,
	#instVars : [
		'selection'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #execute }
GTSpotterElementWithCategoryCommand >> execute [
	self session do: [ :eachEvent |
		eachEvent isUserSelectionClass ifTrue: [ self updateSelection: eachEvent ].
		eachEvent isCategorySelection ifTrue: [ self updateCategory: eachEvent ].
	]
]

{ #category : #update }
GTSpotterElementWithCategoryCommand >> updateCategory: anEvent [
	selection ifNil: [ ^ anEvent markAsStrange: 'Category selection before element selection.' ].
	selection selectedCategoryEvent: anEvent.
	anEvent selectedElementEvent: selection.
	selection := nil.
]

{ #category : #update }
GTSpotterElementWithCategoryCommand >> updateSelection: anEvent [
	selection ifNotNil: [ selection markAsStrange: 'More element selections before category selection.' ].
	selection := anEvent.
]
