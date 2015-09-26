Class {
	#name : #GTExampleTestCase,
	#superclass : #TestCase,
	#instVars : [
		'result'
	],
	#category : #'GT-Inspector-Examples-Tools'
}

{ #category : #testing }
GTExampleTestCase class >> isAbstract [
	^ self name = #GTExampleTestCase
]

{ #category : #configuration }
GTExampleTestCase >> packageNames [
	^ {  }
]

{ #category : #private }
GTExampleTestCase >> packages: aCollection [
	| packages |
	packages := OrderedCollection new.
	RPackageOrganizer default packages do: [ :package |
		aCollection do: [ :packageName |
			(package matchesPackagePattern: packageName) ifTrue: [ 
				packages add: package ] ] ].
	^ packages
]

{ #category : #private }
GTExampleTestCase >> run: aResult [
	result := aResult.
	[ super run: aResult ] ensure: [ result := nil ]
]

{ #category : #private }
GTExampleTestCase >> runCase [
	result ifNil: [ result := self classForTestResult new " fake for debug runner " ].
	super runCase. 
]

{ #category : #private }
GTExampleTestCase >> runExample: example fromContainer: aContainer [
	" this is not the testing tool we have in mind, but a temporary solution to integrate examples into the currently existing testing tools "
	| exampleResult |
	example ignoreTest ifTrue: [ ^ self ].
	self shouldnt: [ exampleResult := example run ] raise: Error.
	exampleResult isError 
		ifTrue: [ ^ result class signalErrorWith: exampleResult asString  ].
	exampleResult isFailure 
		ifTrue: [ ^ result class signalFailureWith: exampleResult asString  ] 
]

{ #category : #private }
GTExampleTestCase >> runExampleContainers: aCollection [
	aCollection do: [ :container | 
		container gtExamplesContained do: [ :example | 
			self runExample: example fromContainer: container ] ]
]

{ #category : #tests }
GTExampleTestCase >> testExamples [
	" default testcase "
	self runExampleContainers: (self packages: self packageNames)
]
