Class {
	#name : #GTACollection,
	#superclass : #OrderedCollection,
	#instVars : [
		'options'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTACollection >> duration [
	^ self end - self start
]

{ #category : #accessing }
GTACollection >> end [
	self ifEmpty: [ ^ 0 ].
	^ self last end
]

{ #category : #accessing }
GTACollection >> optionAt: key [
	^ self optionAt: key ifAbsent: [ nil ]
]

{ #category : #accessing }
GTACollection >> optionAt: key ifAbsent: absentBlock [
	options ifNil: [ ^ absentBlock value ].
	^ options at: key ifAbsent: absentBlock
]

{ #category : #accessing }
GTACollection >> optionAt: key ifAbsentPut: absentBlock [
	options ifNil: [ options := Dictionary new ].
	^ options at: key ifAbsentPut: absentBlock
]

{ #category : #accessing }
GTACollection >> optionAt: key put: value [
	options ifNil: [ options := Dictionary new ].
	^ options at: key put: value
]

{ #category : #accessing }
GTACollection >> start [
	self ifEmpty: [ ^ 0 ].
	^ self first start
]
