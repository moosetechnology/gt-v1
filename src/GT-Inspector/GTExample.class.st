"
This encapsulates one example.
"
Class {
	#name : #GTExample,
	#superclass : #Object,
	#instVars : [
		'methodReference',
		'result',
		'name',
		'parentExample'
	],
	#category : #'GT-Inspector'
}

{ #category : #'as yet unclassified' }
GTExample class >> exempleDependencyPragma [

	^ #gtExampleFrom:
]

{ #category : #'as yet unclassified' }
GTExample class >> fromMethodReference: aMethodReference [
	| newExample dependencyPragma |

	newExample := self new methodReference: aMethodReference.
	dependencyPragma := aMethodReference compiledMethod pragmas detect: [ :each | each keyword = self exempleDependencyPragma ] ifNone: [ nil ].
	dependencyPragma ifNotNil: [
		newExample parentExample: (self fromMethodReference: (aMethodReference realClass compiledMethodAt: (dependencyPragma argumentAt: 1)) asRingDefinition)  ].
	^ newExample
]

{ #category : #'as yet unclassified' }
GTExample class >> fromPragma: aPragma [
	
	^ self fromMethodReference: aPragma method asRingDefinition
]

{ #category : #accessing }
GTExample >> childrenExamples [
	
	^ ((Pragma 
		allNamed: self class exempleDependencyPragma 
		in: self targetClass) select: [ :aPragma | 
			(aPragma argumentAt: 1) = self methodReference selector]) 
				ifEmpty: [ #() ]
				ifNotEmpty: [ :pragmas | 
					pragmas collect: [ :each | GTExample fromPragma: each ] ]
]

{ #category : #accessing }
GTExample >> hasParentExample [

	^ self parentExample notNil
]

{ #category : #accessing }
GTExample >> methodReference [
	^ methodReference
]

{ #category : #accessing }
GTExample >> methodReference: anObject [
	methodReference := anObject
]

{ #category : #accessing }
GTExample >> name [
	^ name
]

{ #category : #accessing }
GTExample >> parentExample [

	^ parentExample
]

{ #category : #accessing }
GTExample >> parentExample: anExample [

	parentExample := anExample
]

{ #category : #accessing }
GTExample >> result [

	^ result ifNil: [ result := self hasParentExample
			ifFalse: [ self targetClass theNonMetaClass perform: self methodReference selector ]
			ifTrue: [ self targetClass theNonMetaClass 
				perform: self methodReference selector
				with: parentExample result ] ]
]

{ #category : #accessing }
GTExample >> rootExample [
	| currentExample |

	currentExample := self.
	[ currentExample parentExample ] whileNotNil: [
		currentExample := currentExample parentExample ].
	^ currentExample
]

{ #category : #accessing }
GTExample >> targetClass [

	^ methodReference realClass
]

{ #category : #accessing }
GTExample >> withAllParentExamples [
	| allParentExamples currentExample |

	allParentExamples := OrderedCollection new.
	currentExample := self.
	[ currentExample ] whileNotNil: [
		allParentExamples add: currentExample.
		currentExample := currentExample parentExample ].
	^ allParentExamples
]
