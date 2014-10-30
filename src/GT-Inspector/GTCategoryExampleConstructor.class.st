Class {
	#name : #GTCategoryExampleConstructor,
	#superclass : #GTExampleConstructor,
	#instVars : [
		'categoryName'
	],
	#category : #'GT-Inspector-Examples'
}

{ #category : #'instance creation' }
GTCategoryExampleConstructor class >> for: aCategory [

	^ self new categoryName: aCategory
]

{ #category : #testing }
GTCategoryExampleConstructor >> appliesTo: aMethod [

	^ aMethod category = self categoryName
]

{ #category : #accessing }
GTCategoryExampleConstructor >> categoryName [
	
	^ categoryName
]

{ #category : #accessing }
GTCategoryExampleConstructor >> categoryName: anObject [
	
	categoryName := anObject
]

{ #category : #'example creation' }
GTCategoryExampleConstructor >> createExampleFor: aMethodReference [

	^ self exampleClass new
		title: aMethodReference selector

]
