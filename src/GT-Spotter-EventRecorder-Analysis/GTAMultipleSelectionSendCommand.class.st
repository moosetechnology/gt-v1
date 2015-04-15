Class {
	#name : #GTAMultipleSelectionSendCommand,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #accessing }
GTAMultipleSelectionSendCommand class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #api }
GTAMultipleSelectionSendCommand >> selection: result in: aCollection [
	^ (result notNil and: [result size = 1]) 
		ifTrue: [result anyOne] 
		ifFalse: [ aCollection species withAll: result ]
]
