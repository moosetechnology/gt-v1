"
This encapsulates one example.
"
Class {
	#name : #GTExample,
	#superclass : #Object,
	#instVars : [
		'result',
		'title',
		'provider',
		'selector',
		'parentExample',
		'extractionStrategy'
	],
	#category : #'GT-Inspector-Examples'
}

{ #category : #accessing }
GTExample >> childrenExamples [
	
	^ self extractionStrategy 
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ self extractionStrategy childrenExamplesFor: self ]
]

{ #category : #accessing }
GTExample >> extractionStrategy [
	^ extractionStrategy
]

{ #category : #accessing }
GTExample >> extractionStrategy: anObject [
	extractionStrategy := anObject
]

{ #category : #presentations }
GTExample >> gtDisplaySourceIn: composite [

	^ self methodReference gtInspectorSourceIn: composite
]

{ #category : #accessing }
GTExample >> hasParentExample [

	^ parentExample notNil
]

{ #category : #testing }
GTExample >> isGTExample [
	
	^ true
]

{ #category : #accessing }
GTExample >> methodReference [

	^ (self provider class compiledMethodAt: self selector) asRingDefinition
]

{ #category : #accessing }
GTExample >> parentExample: anExample [

	parentExample := anExample
]

{ #category : #accessing }
GTExample >> provider [

	^ provider
]

{ #category : #accessing }
GTExample >> provider: anObject [

	provider := anObject
]

{ #category : #accessing }
GTExample >> result [

	^ result ifNil: [ result := self hasParentExample
			ifFalse: [ self provider perform: self selector ]
			ifTrue: [ self provider perform: self selector with: parentExample result ] ]
]

{ #category : #accessing }
GTExample >> selector [

	^ selector
]

{ #category : #accessing }
GTExample >> selector: aSymbol [

	selector := aSymbol
]

{ #category : #accessing }
GTExample >> title [

	^ title 
		ifNil: [ self result ]
		ifNotNil: [ title ]
]

{ #category : #accessing }
GTExample >> title: aString [
	title := aString
]
