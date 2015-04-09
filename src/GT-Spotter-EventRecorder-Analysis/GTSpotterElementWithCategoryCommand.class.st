Class {
	#name : #GTSpotterElementWithCategoryCommand,
	#superclass : #GTSpotterAnalysisCommand,
	#instVars : [
		'selection',
		'category'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTSpotterElementWithCategoryCommand class >> analysisOrder [
	^ 2
]

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
	category := anEvent.
]

{ #category : #update }
GTSpotterElementWithCategoryCommand >> updateSelection: anEvent [
	selection ifNotNil: [ 
		category 
			ifNil: [ selection markAsStrange: 'There is no category selection before.' ]
			ifNotNil: [ :aCategory | 
				selection selectedCategoryEvent: aCategory.
				aCategory selectedElementEvent: selection.  ]
		 ].
	selection := anEvent.
]
