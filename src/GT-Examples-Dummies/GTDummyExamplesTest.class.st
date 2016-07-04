Class {
	#name : #GTDummyExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Examples-Dummies-Tests'
}

{ #category : #accessing }
GTDummyExamplesTest >> allExamplesDummiesProviders [
	^ { 
		GTDummyExamples. 
		GTDummyExamplesPragmas. 
		GTDummyExamplesRecursive. 
		GTDummyExamplesWithDependencies. 
		GTDummyExamplesWithExternalDependencies.
		GTDummyExamplesWithExceptions 
	}
]

{ #category : #utils }
GTDummyExamplesTest >> examplesInClasses: aSelector do: aBlock [
	| classes examples |
	self shouldnt: [ classes  := (self perform: aSelector) ] raise: Error.
	classes do: [ :each |
		self shouldnt: [ examples := each gtExamples ] raise: Error.
		examples do: [ :example |
			self shouldnt: [ aBlock value: example ] raise: Error ] ]
]

{ #category : #accessing }
GTDummyExamplesTest >> invalidExamplesDummiesProviders [
	^ { 
		GTDummyExamplesInvalid.
	}
]

{ #category : #accessing }
GTDummyExamplesTest >> recursiveExamplesDummiesProviders [
	^ { 
		GTDummyExamplesRecursive.
	}
]

{ #category : #tests }
GTDummyExamplesTest >> testExists [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self assert: example exists ]
]

{ #category : #tests }
GTDummyExamplesTest >> testInvalidDefinitions [
	self examplesInClasses: #invalidExamplesDummiesProviders do: [ :example | 
		self assert: example exists.
		self deny: example isValid ]
]

{ #category : #tests }
GTDummyExamplesTest >> testIsEquals [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self assert: (example = example) ]
]

{ #category : #tests }
GTDummyExamplesTest >> testIsGTExample [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self assert: example isGTExample ]
]

{ #category : #tests }
GTDummyExamplesTest >> testMatchesMethod [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self assert: (example matchesMethod: example method) ]
]

{ #category : #tests }
GTDummyExamplesTest >> testRecursiveDefinitions [
	self examplesInClasses: #recursiveExamplesDummiesProviders do: [ :example | 
		self assert: example exists.
		self assert: example hasValidArguments.
		self assert: example hasValidDependencies.
		self assert: (example method selector = #h or: [ example isValid not ]) ]
]

{ #category : #tests }
GTDummyExamplesTest >> testResult [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self shouldnt: [ example result ] raise: Error.
		self shouldnt: [ example returnValue ] raise: Error.
		self shouldnt: [ example detachResultFromSystem ] raise: Error.
		self shouldnt: [ example result ] raise: Error.
		self shouldnt: [ example returnValue ] raise: Error. ]
]

{ #category : #tests }
GTDummyExamplesTest >> testRun [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self shouldnt: [ example run ] raise: Error ]
]
