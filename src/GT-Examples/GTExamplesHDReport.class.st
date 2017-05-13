"
I am a report that once executed produces an XML result that can be integrated in Hudson/Jenkins in order to display run/failing examples as tests.
"
Class {
	#name : #GTExamplesHDReport,
	#superclass : #HDReport,
	#instVars : [
		'suite',
		'stream',
		'progressFile',
		'examples',
		'examplesFailures',
		'examplesErrors',
		'examplesPosition',
		'executionTime'
	],
	#category : #'GT-Examples-Testing'
}

{ #category : #running }
GTExamplesHDReport class >> runPackage: aString [
	^ (RPackage organizer packageNamed: aString) gtExamplesContained 
]

{ #category : #running }
GTExamplesHDReport >> begin [
	progressFile nextPutAll: 'running suite: ';
		nextPutAll: 'Examples' ; crlf; flush.
		
	stream := StandardFileStream forceNewFileNamed: 'Examples' , '-Test.xml'.
	stream := MultiByteFileStream newFrom: stream.
	stream nextPutAll: '<?xml version="1.0" encoding="UTF-8"?>'; lf.
	stream nextPutAll: '<testsuite name="'; nextPutAll: (self encode: 'Examples'); 
		nextPutAll: '" tests="'; print: examples size; nextPutAll: '">'.
	
	"Now this is ugly. We want to update the time and the number of failures and errors, but still at the same time stream a valid XML. So remember this position and add some whitespace, that we can fill later."
	examplesPosition := stream position - 1.
	stream nextPutAll: (String new: 100 withAll: $ ); lf
]

{ #category : #private }
GTExamplesHDReport >> beginExample: aTestCase runBlock: aBlock [
	| time |
	progressFile 
		nextPutAll: 'starting testcase: ' ; 
		nextPutAll: aTestCase class name; 
		nextPutAll:'>>';
		nextPutAll: aTestCase selector; 
		nextPutAll: ' ... '; 
		flush.
		
	time := aBlock timeToRun.
	stream tab; 
		nextPutAll: '<testcase classname="'; 
		nextPutAll: (self encode: (aTestCase class category copyReplaceAll: '-' with: '.')); 
		nextPut: $.; nextPutAll: (self encode: aTestCase class name); 
		nextPutAll: '" name="'; nextPutAll: (self encode: aTestCase selector); 
		nextPutAll: '" time="'; print: (time asMilliSeconds / 1000.0); 
		nextPutAll: '">'; lf
	

]

{ #category : #private }
GTExamplesHDReport >> beginExamples: anExample runBlock: aBlock [
	| time |
	progressFile nextPutAll: 'starting example: '.
	anExample printOn: progressFile.
	progressFile nextPutAll: ' ... '; cr; flush.
	time := aBlock timeToRun.
	stream tab; 
		nextPutAll: '<testcase classname="'; 
		nextPutAll: (self encode: (anExample class category copyReplaceAll: '-' with: '.')); 
		nextPut: $.; nextPutAll: (self encode: anExample class name); 
		nextPutAll: '" name="'; nextPutAll: (self encode: anExample selector); 
		nextPutAll: '" time="'; print: (time asMilliSeconds / 1000.0); 
		nextPutAll: '">'; lf
]

{ #category : #private }
GTExamplesHDReport >> beginTestCase: aTestCase runBlock: aBlock [
	| time |
	progressFile nextPutAll: 'starting example: '.
	aTestCase printOn: progressFile.
	progressFile nextPutAll: ' ... '; flush.
	time := aBlock timeToRun.
	stream tab; 
		nextPutAll: '<testcase classname="'; 
		nextPutAll: (self encode: (aTestCase class category copyReplaceAll: '-' with: '.')); 
		nextPut: $.; nextPutAll: (self encode: aTestCase class name); 
		nextPutAll: '" name="'; nextPutAll: (self encode: aTestCase selector); 
		nextPutAll: '" time="'; print: (time asMilliSeconds / 1000.0); 
		nextPutAll: '">'; lf
	

]

{ #category : #running }
GTExamplesHDReport >> done [
	"just close the file"
	[ progressFile close ] on: Error do: []
]

{ #category : #running }
GTExamplesHDReport >> end [		
	stream tab; nextPutAll: '<system-out><![CDATA[]]></system-out>'; lf.
	stream tab; nextPutAll: '<system-err><![CDATA[]]></system-err>'; lf.
	stream nextPutAll: '</testsuite>'.
	
	stream position: examplesPosition.
	stream 
"		nextPutAll: ' failures=""'; print: examplesFailures; "
		nextPutAll: '" errors="'; print: examplesErrors; 
		nextPutAll: '" time="'; print: executionTime asMilliSeconds / 1000.0; 
		nextPutAll: '">'.
	stream close.
	
	progressFile 
		nextPutAll: 'finished running suite: ';
		nextPutAll: 'Examples';
		close
]

{ #category : #private }
GTExamplesHDReport >> endExample [
	stream tab; nextPutAll: '</testcase>'; lf.
	progressFile nextPutAll: 'finished' ; crlf; flush.

]

{ #category : #accessing }
GTExamplesHDReport >> exampleErrors [
	^ examplesErrors
]

{ #category : #accessing }
GTExamplesHDReport >> exampleFailures [
	^ examplesFailures
]

{ #category : #accessing }
GTExamplesHDReport >> examplePassing [ 
	^ self suiteTotal - self suiteFailures - self suiteErrors
]

{ #category : #initialization }
GTExamplesHDReport >> examples: aCollection [
	examples := aCollection
]

{ #category : #accessing }
GTExamplesHDReport >> examplesErrors [
	^ examplesErrors
]

{ #category : #accessing }
GTExamplesHDReport >> examplesFailures [
	^ examplesFailures
]

{ #category : #accessing }
GTExamplesHDReport >> examplesPassing [ 
	^ self suiteTotal - self suiteFailures - self suiteErrors
]

{ #category : #accessing }
GTExamplesHDReport >> examplesTotal [
	^ suite 
		ifNotNil: [ suite tests size ]
		ifNil: [ 0 ]
]

{ #category : #testing }
GTExamplesHDReport >> hasErrors [ 
	^ examplesErrors ~= 0
]

{ #category : #testing }
GTExamplesHDReport >> hasFailures [ 
	^ examplesFailures ~= 0
]

{ #category : #testing }
GTExamplesHDReport >> hasFailuresOrErrors [
	^ self hasFailures or: [ self hasErrors ]
]

{ #category : #initialization }
GTExamplesHDReport >> initialize [
	super initialize.
	executionTime := 0 asDuration.
	examplesPosition := examplesFailures := examplesErrors := 0.
	progressFile := StandardFileStream forceNewFileNamed: 'progress.log'
	
]

{ #category : #initialization }
GTExamplesHDReport >> initializeExamples: aCollection entitled: aString [
	examples := aCollection.
	title := aString
]

{ #category : #running }
GTExamplesHDReport >> run [
	Author uniqueInstance
		ifUnknownAuthorUse: 'hudson'
		during: [ [ 
			self setUp.
			executionTime := [ self runAll ]
				timeToRun ]
					ensure: [ self tearDown ] ]
]

{ #category : #running }
GTExamplesHDReport >> runAll [
	CurrentExecutionEnvironment runTestsBy: [ 
		examples tests do: [ :each | each run: self ]
	]
]

{ #category : #running }
GTExamplesHDReport >> runExample: aTestCase [
	| error stack  |
	self
		beginTestCase: aTestCase
		runBlock: [ [ [ aTestCase runCaseManaged ]
			on: Halt, Error, TestFailure
			do: [ :err |
				error := err.
				aTestCase shouldPass ifTrue: [
					self
						serializeError: error
						of: aTestCase ].
				stack := self
					stackTraceString: err
					of: aTestCase ]]
						on: TestSkip
						do: [ :err | "nothing to do..." ] ].
	
	self
		writeError: error
		andStack: stack
		for: aTestCase.
	self endTestCase
]

{ #category : #running }
GTExamplesHDReport >> serializeError: error of: aTestCase [
	"We got an error from a test, let's serialize it so we can properly debug it later on..."
	| context testCaseMethodContext |
	
	context := error signalerContext.
	testCaseMethodContext := context findContextSuchThat: [ :ctx| 
		ctx receiver == aTestCase and: [ ctx methodSelector == #performTest ]].
	context := context copyTo: testCaseMethodContext.
	
	[ FuelOutStackDebugAction
		serializeTestFailureContext: context sender 		
		toFileNamed: aTestCase class name asString,'-', aTestCase selector, '.fuel' ] 
	on: Error 
	do: [:err| "simply continue..." ]


]

{ #category : #running }
GTExamplesHDReport >> setUp [
	progressFile nextPutAll: 'running suite: ';
		nextPutAll: suite name ; crlf; flush.
		
	stream := StandardFileStream forceNewFileNamed: suite name , '-Test.xml'.
	stream := MultiByteFileStream newFrom: stream.
	stream nextPutAll: '<?xml version="1.0" encoding="UTF-8"?>'; lf.
	stream nextPutAll: '<testsuite name="'; nextPutAll: (self encode: suite name); 
		nextPutAll: '" tests="'; print: suite tests size; nextPutAll: '">'.
	
	"Now this is ugly. We want to update the time and the number of failures and errors, but still at the same time stream a valid XML. So remember this position and add some whitespace, that we can fill later."
	examplesPosition := stream position - 1.
	stream nextPutAll: (String new: 100 withAll: $ ); lf.
	
	"Initialize the test resources."
	suite resources do: [ :each |
		each isAvailable
			ifFalse: [ each signalInitializationError ] ]
]

{ #category : #private }
GTExamplesHDReport >> stackTraceString: err of: aTestCase [
	^ String streamContents: [ :str | 
		| context |
		context := err signalerContext.
		[ context isNil or: [ context receiver == aTestCase and: [ context methodSelector == #runCase ] ] ] whileFalse: [
			str print: context; lf.
			context := context sender ] ] 
]

{ #category : #running }
GTExamplesHDReport >> tearDown [
	suite resources 
		do: [ :each | each reset ].
		
	stream tab; nextPutAll: '<system-out><![CDATA[]]></system-out>'; lf.
	stream tab; nextPutAll: '<system-err><![CDATA[]]></system-err>'; lf.
	stream nextPutAll: '</testsuite>'.
	
	stream position: examplesPosition.
	stream 
		nextPutAll: ' failures="'; print: examplesFailures; 
		nextPutAll: '" errors="'; print: examplesErrors; 
		nextPutAll: '" time="'; print: executionTime asMilliSeconds / 1000.0; 
		nextPutAll: '">'.
	stream close.
	
	progressFile 
		nextPutAll: 'finished running suite: ';
		nextPutAll: suite name;
		close
]

{ #category : #private }
GTExamplesHDReport >> writeError: anError andStack: aString for: aTestCase [
	"XML tag is now open"
	anError ifNotNil: [
		(anError isKindOf: AssertionFailure)
			ifTrue: [ self writeFailure: anError stack: aString ]
			ifFalse: [ self writeError: anError stack: aString ] ]
]

{ #category : #private }
GTExamplesHDReport >> writeError: error stack: stack [
	examplesErrors := examplesErrors + 1.
	stream tab; tab; nextPutAll: '<error type="'.
	self writeException: error stack: stack.
	stream nextPutAll: '</error>'; lf
]

{ #category : #private }
GTExamplesHDReport >> writeException: error stack: stack. [

	stream 
		nextPutAll: (self encode: error class name); 
		nextPutAll: '" message="'; nextPutAll: (self encode: (error messageText ifNil: [ error description ])); 
		nextPutAll: '">'; 
		nextPutAll: (self encode: stack).
]

{ #category : #private }
GTExamplesHDReport >> writeFailure: error stack: stack [
	examplesFailures := examplesFailures + 1.
	stream tab; tab; nextPutAll: '<failure type="'.
	self writeException: error stack: stack.  
	stream	nextPutAll: '</failure>'; lf
]
