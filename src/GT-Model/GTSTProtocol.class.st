Class {
	#name : #GTSTProtocol,
	#superclass : #GTSTNamedModel,
	#instVars : [
		'glmBehavior'
	],
	#category : #'GT-Model'
}

{ #category : #accessing }
GTSTProtocol >> glmBehavior [
	^ glmBehavior
]

{ #category : #accessing }
GTSTProtocol >> glmBehavior: anObject [ 
	glmBehavior := anObject
]

{ #category : #testing }
GTSTProtocol >> isCategory [
	^ true
]

{ #category : #accessing }
GTSTProtocol >> methods [
	^ (self glmBehavior stBehavior organization listAtCategoryNamed: self name) asSortedCollection collect: 
		[ :each | 
		GTSTMethod new
			name: each;
			glmCategory: self;
			yourself ]
]
