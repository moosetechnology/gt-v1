Class {
	#name : #GTSUnitExampleFailingTest,
	#superclass : #TestCase,
	#category : #'GT-SUnitDebugger'
}

{ #category : #'as yet unclassified' }
GTSUnitExampleFailingTest class >> isAbstract [
	^ true
]

{ #category : #'as yet unclassified' }
GTSUnitExampleFailingTest class >> isUnitTest [
	^ false
]

{ #category : #tests }
GTSUnitExampleFailingTest >> testFailingDate [
	|aDateAndTime|
	
	aDateAndTime :=  DateAndTime localTimeZone: TimeZone default; dosEpoch.
	self assert: (aDateAndTime offset: '0:12:00:00')  equals: '1980-01-01T13:00:00+12:00' asDateAndTime
]

{ #category : #tests }
GTSUnitExampleFailingTest >> testFailingText [

	self assert: 'I like pie  
pizza pie 
apple pie 
rad squared pi 
and other PIes'
	equals: 'I like pie  
pizza pie 
potato pie 
rad squared pi 
and other PIes'
]

{ #category : #tests }
GTSUnitExampleFailingTest >> testMultiValuedStreaming [
	| headers keysAndValues |
	headers := ZnHeaders new.
	headers at: 'Set-Cookie' put: 'foo=1'.
	headers at: 'Set-Cookie' add: 'bar=1'.
	headers at: 'Content-TYPE' put: 'text/plain'.
	headers at: 'Content-Length' put: '128'.
	keysAndValues := OrderedCollection streamContents: [ : stream |
		headers headersDo: [ :key :value |
			stream nextPut: key; nextPut: value ] ].
	self assert: keysAndValues equals: #('Set-Cookie' 'foo=1' 'Set-Cookie' 'bar=1' 'Content-Length' '128' 'Content-TYPE' 'text/plain') asOrderedCollection 
	
	
]
