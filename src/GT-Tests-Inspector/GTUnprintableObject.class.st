"
This is a test helper class for testing an error in printString
"
Class {
	#name : #GTUnprintableObject,
	#superclass : #Object,
	#category : #'GT-Tests-Inspector'
}

{ #category : #'as yet unclassified' }
GTUnprintableObject >> printString [
	1/0
]
