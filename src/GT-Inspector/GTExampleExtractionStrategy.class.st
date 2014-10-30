"
I extract and create examples from an example provider.
"
Class {
	#name : #GTExampleExtractionStrategy,
	#superclass : #Object,
	#instVars : [
		'exampleConstructors'
	],
	#category : #'GT-Inspector-Examples'
}

{ #category : #adding }
GTExampleExtractionStrategy >> addExampleConstructor: anObject [

	exampleConstructors add: anObject
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> childrenExamplesFor: anExample [

	^ ((Pragma 
		allNamed: self exempleDependencyPragma 
		in: anExample provider class) select: [ :aPragma | 
			(aPragma argumentAt: 1) = anExample selector]) 
				ifEmpty: [ #() ]
				ifNotEmpty: [ :pragmas | 
					pragmas collect: [ :each | 
						(self fromDependencyPragma: each in: anExample provider) ] ]
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> createExampleFor: aMethod from: anExampleProvider [ 
	
	^ (self locateConstructorFor: aMethod)
		ifNil: [ nil ]
		ifNotNil: [ :aConstructor | self createExampleFor: aMethod from: anExampleProvider using: aConstructor ] 
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> createExampleFor: aMethod from: anExampleProvider using: aConstructor [ 
	| newExample |

	newExample := (aConstructor createExampleFor: aMethod) 
		selector: aMethod selector;
		extractionStrategy: self;
		provider: anExampleProvider.
	newExample parentExample: (self parentExampleFor: newExample).
	^ newExample
]

{ #category : #accessing }
GTExampleExtractionStrategy >> exempleDependencyPragma [

	^ #exampleFrom:
]

{ #category : #private }
GTExampleExtractionStrategy >> fromDependencyPragma: aPragma in: anExampleProvider [

	^ self 
		createExampleFor: aPragma method
		from: anExampleProvider
]

{ #category : #initialization }
GTExampleExtractionStrategy >> initialize [
	super initialize.
	
	exampleConstructors := OrderedCollection new
]

{ #category : #private }
GTExampleExtractionStrategy >> locateConstructorFor: aMethod [

	^ exampleConstructors 
		detect: [ :aConstructor | aConstructor appliesTo: aMethod ]
		ifNone: [ nil ]
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> parentExampleFor: anExample [
	| dependencyPragma |
	
	dependencyPragma := anExample methodReference compiledMethod pragmas 
		detect: [ :each | each keyword = self exempleDependencyPragma ] 
		ifNone: [ nil ].

	^ dependencyPragma 
		ifNil: [ nil ]
		ifNotNil: [
			self 
				createExampleFor: (anExample methodReference realClass 
					compiledMethodAt: (dependencyPragma argumentAt: 1))
				from: anExample provider ].
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> rootExamplesFor: anExampleProvider [

	^ anExampleProvider class methods 
		inject: OrderedCollection new
		into: [ :newExamples :aMethod |
			"Not the best solution for filtering root examples"
			aMethod selector isUnary ifTrue: [  
				(self createExampleFor: aMethod from: anExampleProvider) ifNotNil: [ :anExample |
					newExamples add: anExample ] ].
			newExamples ]
]
