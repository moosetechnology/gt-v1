Class {
	#name : #GTSTVariable,
	#superclass : #GTSTNamedModel,
	#instVars : [
		'glmBehavior'
	],
	#category : #'GT-Model'
}

{ #category : #accessing }
GTSTVariable >> accessingMethods [
	| selectors |
	selectors := self glmBehavior stBehavior whichSelectorsAccess: self name.
	^ self glmBehavior methods select: [:each | selectors includes: each name ]
]

{ #category : #accessing }
GTSTVariable >> glmBehavior [
	^ glmBehavior
]

{ #category : #accessing }
GTSTVariable >> glmBehavior: anObject [
	glmBehavior := anObject
]
