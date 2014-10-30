Class {
	#name : #GTExampleProviderDelegator,
	#superclass : #Object,
	#instVars : [
		'targetProvider',
		'extractionStrategy'
	],
	#category : #'GT-Inspector-Examples'
}

{ #category : #accessing }
GTExampleProviderDelegator >> extractionStrategy [
	
	^ extractionStrategy
]

{ #category : #accessing }
GTExampleProviderDelegator >> extractionStrategy: anObject [
	
	extractionStrategy := anObject
]

{ #category : #'as yet unclassified' }
GTExampleProviderDelegator >> gtExamples [

	^	self gtExamplesExtractionStrategy rootExamplesFor: self targetProvider
]

{ #category : #'as yet unclassified' }
GTExampleProviderDelegator >> gtExamplesExtractionStrategy [

	^ self extractionStrategy 
		ifNil: [ self targetProvider gtExamplesExtractionStrategy ]
		ifNotNil: [ self extractionStrategy  ]
]

{ #category : #accessing }
GTExampleProviderDelegator >> targetProvider [
	
	^ targetProvider
]

{ #category : #accessing }
GTExampleProviderDelegator >> targetProvider: anObject [
	
	targetProvider := anObject
]
