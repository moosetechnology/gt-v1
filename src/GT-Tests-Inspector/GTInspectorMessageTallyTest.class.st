Class {
	#name : #GTInspectorMessageTallyTest,
	#superclass : #GTInspectorSmokeTest,
	#category : #'GT-Tests-Inspector'
}

{ #category : #tests }
GTInspectorMessageTallyTest >> objectToTest [ 
	^ MessageTally new 
		spyEvery: 1 on: [10 timesRepeat: [1.23 printString]]
]
