Extension { #name : #MessageTally }

{ #category : #'*GT-Examples-Examples' }
MessageTally class >> gtExampleSimplePrintString [
	<gtExample>
	<label: 'Simple printString'>
	
	^ MessageTally new 
		spyEvery: 1 on: [10 timesRepeat: [1.23 printString]];
		yourself
]
