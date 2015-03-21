"
I extract and create examples from an example provider.
"
Class {
	#name : #GTExampleExtractionStrategy,
	#superclass : #Object,
	#category : #'GT-Inspector-Examples'
}

{ #category : #'example creation' }
GTExampleExtractionStrategy >> childrenExamplesFor: anExample [

	^ ((Pragma 
		allNamed: self exampleDependencyPragma 
		in: anExample provider class) select: [ :aPragma | 
			(aPragma argumentAt: 1) = anExample selector]) 
				ifEmpty: [ #() ]
				ifNotEmpty: [ :pragmas | 
					pragmas collect: [ :each | 
						(self createExampleFromDependencyPragma: each from: anExample provider) ] ]
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> createExampleForExamplePragma: aPragma from: anExampleProvider [
	| example |
	
	example := self createExampleForMethod: aPragma method asRingDefinition from: anExampleProvider.
	aPragma arguments size = 1 
		ifTrue: [ example title: (aPragma argumentAt: 1) ]
		ifFalse: [ example title: aPragma selector ].
	^ example
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> createExampleForMethod: aMethod from: anExampleProvider [
	| newExample |

	newExample := self exampleClass new
		selector: aMethod selector;
		extractionStrategy: self;
		provider: anExampleProvider.
	newExample parentExample: (self parentExampleFor: newExample).
	^ newExample
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> createExampleFromDependencyPragma: aPragma from: anExampleProvider [

	^ self 
		createExampleForExamplePragma: (aPragma method pragmas detect: [:each | 
				self examplePragmas includes: each keyword])
		from: anExampleProvider
]

{ #category : #accessing }
GTExampleExtractionStrategy >> exampleClass [

	^ GTExample
]

{ #category : #accessing }
GTExampleExtractionStrategy >> exampleDependencyPragma [

	^ #exampleFrom:
]

{ #category : #accessing }
GTExampleExtractionStrategy >> examplePragmas [

	^ #(example example:)
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> parentExampleFor: anExample [
	| dependencyPragma |
	
	dependencyPragma := anExample methodReference compiledMethod pragmas 
		detect: [ :each | each keyword = self exampleDependencyPragma ] 
		ifNone: [ nil ].

	^ dependencyPragma 
		ifNil: [ nil ]
		ifNotNil: [
			self 
				createExampleForMethod: (anExample methodReference realClass 
					compiledMethodAt: (dependencyPragma argumentAt: 1))
				from: anExample provider ].
]

{ #category : #'example creation' }
GTExampleExtractionStrategy >> rootExamplesFor: anExampleProvider [
	| pragmas |

	pragmas := self examplePragmas 
		inject: OrderedCollection new
		into: [ :result :pragma |
			result , (Pragma 
				allNamed: pragma 
				in: anExampleProvider class)].
	^ (pragmas select: [ :each | each selector isUnary ])
			ifEmpty: [ #() ]
			ifNotEmpty: [ :examplePragmas | examplePragmas collect: [ :eachPragma | 
				self createExampleForExamplePragma: eachPragma from: anExampleProvider ] ]
]
