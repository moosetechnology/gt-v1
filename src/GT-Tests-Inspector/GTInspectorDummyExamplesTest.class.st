Class {
	#name : #GTInspectorDummyExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Inspector'
}

{ #category : #accessing }
GTInspectorDummyExamplesTest >> allExamplesDummiesProviders [
	^ { 
		GTDummyExamples. 
		GTDummyExamplesPragmas. 
		GTDummyExamplesRecursive. 
		GTDummyExamplesWithDependencies. 
		GTDummyExamplesWithExceptions 
	}
]

{ #category : #utils }
GTInspectorDummyExamplesTest >> examplesInClasses: aSelector do: aBlock [
	| classes examples |
	self shouldnt: [ classes  := (self perform: aSelector) ] raise: Error.
	classes do: [ :each |
		self shouldnt: [ examples := each gtExamples ] raise: Error.
		examples do: [ :example |
			self shouldnt: [ aBlock value: example ] raise: Error ] ]
]

{ #category : #accessing }
GTInspectorDummyExamplesTest >> invalidExamplesDummiesProviders [
	^ { 
		GTDummyExamplesInvalid.
	}
]

{ #category : #accessing }
GTInspectorDummyExamplesTest >> recursiveExamplesDummiesProviders [
	^ { 
		GTDummyExamplesRecursive.
	}
]

{ #category : #tests }
GTInspectorDummyExamplesTest >> testExists [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self assert: example exists ]
]

{ #category : #tests }
GTInspectorDummyExamplesTest >> testInvalidDefinitions [
	self examplesInClasses: #invalidExamplesDummiesProviders do: [ :example | 
		self assert: example exists.
		self deny: example isValid ]
]

{ #category : #tests }
GTInspectorDummyExamplesTest >> testIsEquals [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self assert: (example = example) ]
]

{ #category : #tests }
GTInspectorDummyExamplesTest >> testIsGTExample [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self assert: example isGTExample ]
]

{ #category : #tests }
GTInspectorDummyExamplesTest >> testMatchesMethod [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self assert: (example matchesMethod: example method) ]
]

{ #category : #tests }
GTInspectorDummyExamplesTest >> testRecursiveDefinitions [
	self examplesInClasses: #recursiveExamplesDummiesProviders do: [ :example | 
		self assert: example exists.
		self assert: example hasValidArguments.
		self assert: example hasValidDependencies.
		self assert: (example method selector = #h or: [ example isValid not ]) ]
]

{ #category : #tests }
GTInspectorDummyExamplesTest >> testResult [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self shouldnt: [ example result ] raise: Error.
		self shouldnt: [ example returnValue ] raise: Error.
		self shouldnt: [ example detachResultFromSystem ] raise: Error.
		self shouldnt: [ example result ] raise: Error.
		self shouldnt: [ example returnValue ] raise: Error. ]
]

{ #category : #tests }
GTInspectorDummyExamplesTest >> testRun [
	self examplesInClasses: #allExamplesDummiesProviders do: [ :example | 
		self shouldnt: [ example run ] raise: Error ]
]
