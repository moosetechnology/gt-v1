Class {
	#name : #GTTestRunner,
	#superclass : #Object,
	#category : #'GT-SpotterExtensions-Core'
}

{ #category : #private }
GTTestRunner class >> basicRunTestForTestCase: aTestCase [
	| result |
	self flag: 'we should only erase the result for aTestCase - sunit does not provide that and we dont want to hack it'.
	
	aTestCase class resetHistory.
	result := aTestCase run.
	result updateResultsInHistory.
	self notify: aTestCase class name, '>>#', aTestCase selector color: (self colorForResult: result)
]

{ #category : #private }
GTTestRunner class >> basicRunTestsForClass: aClass [
	| result |
	aClass resetHistory.
	result := aClass buildSuiteFromAllSelectors run.
	result updateResultsInHistory.
	self notify: aClass name color: (self colorForResult: result)
]

{ #category : #private }
GTTestRunner class >> basicRunTestsForSuite: aSuite [
	| result |
	self flag: 'we should only erase what is in the suite - sunit does not provide that and we dont want to hack it'.

	aSuite tests do: [ :each | each class resetHistory ]. 
	result := aSuite run.
	result updateResultsInHistory.
	self notify: aSuite name color: (self colorForResult: result)
]

{ #category : #private }
GTTestRunner class >> colorForResult: aResult [
	aResult hasErrors ifTrue: [ ^ Color red ].
	aResult hasFailures ifTrue: [ ^ Color yellow ].
	aResult hasPassed ifTrue: [ ^ Color green ].
	^ Color gray
]

{ #category : #public }
GTTestRunner class >> iconForClass: aClass [
	| result |
	result := aClass lastRun.
	(result at: #errors) ifNotEmpty: [ ^ Smalltalk ui icons testRedIcon ].
	(result at: #failures) ifNotEmpty: [ ^ Smalltalk ui icons testYellowIcon ].
	(result at: #passed) ifNotEmpty: [ ^ Smalltalk ui icons testGreenIcon ].
	^ Smalltalk ui icons testNotRunIcon
]

{ #category : #public }
GTTestRunner class >> iconForTestCase: aTestCase [
	| result |
	result := aTestCase class lastRun.
	((result at: #errors) includes: aTestCase selector) ifTrue: [ ^ Smalltalk ui icons testRedIcon ].
	((result at: #failures) includes: aTestCase selector) ifTrue: [ ^ Smalltalk ui icons testYellowIcon ].
	((result at: #passed) includes: aTestCase selector) ifTrue: [ ^ Smalltalk ui icons testGreenIcon ].
	^ Smalltalk ui icons testNotRunIcon
]

{ #category : #private }
GTTestRunner class >> notify: aString color: aColor [
	 GrowlMorph 
		openWithLabel: 'Test Finished'
		contents: aString
		backgroundColor: aColor
		labelColor: Color black
				
]

{ #category : #private }
GTTestRunner class >> run: aBlock [
	[ aBlock on: Error do: [ :exception | " ignore " ] ] fork
]

{ #category : #public }
GTTestRunner class >> runTestForTestCase: aTestCase [
	self run: [ self basicRunTestForTestCase: aTestCase ]
]

{ #category : #public }
GTTestRunner class >> runTestsForClass: aClass [
	self run: [ self basicRunTestsForClass: aClass ]
]

{ #category : #public }
GTTestRunner class >> runTestsForSuite: aSuite [
	self run: [ self basicRunTestsForSuite: aSuite ]
]
