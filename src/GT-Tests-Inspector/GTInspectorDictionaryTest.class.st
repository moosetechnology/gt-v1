Class {
	#name : #GTInspectorDictionaryTest,
	#superclass : #GTInspectorSmokeTest,
	#category : #'GT-Tests-Inspector'
}

{ #category : #tests }
GTInspectorDictionaryTest >> objectToTest [ 
	| dict |
	dict := Dictionary new.
	dict at: 4 put: 2.
	dict at: #a put: 'value'.
	^ dict
]
