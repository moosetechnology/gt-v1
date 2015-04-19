Class {
	#name : #GTAFlexibleResultIconBuilder,
	#superclass : #GTAOrthogonalIconBuilder,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #visitor }
GTAFlexibleResultIconBuilder >> visitSearchFinishedEvent: aGTSpotterEvent [ 
	^ aGTSpotterEvent notEmptyCategories size < 2
		ifTrue: [ self newSearchFinishedForOneCategoryEvent: aGTSpotterEvent ]
		ifFalse: [ self newSearchFinishedForSeveralCategoriesEvent: aGTSpotterEvent ]
]
