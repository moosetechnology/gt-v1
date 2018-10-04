"
A GTEventRecorderFileStorageTest is a test class for testing the behavior of GTEventRecorderFileStorage
"
Class {
	#name : #GTEventRecorderFileStorageTest,
	#superclass : #TestCase,
	#instVars : [
		'fileSystem',
		'storage'
	],
	#category : #'GT-EventRecorder-Server-Tests'
}

{ #category : #asserting }
GTEventRecorderFileStorageTest >> assertLocation: location input: input [
	| file output |
	file := storage directory resolveString: location.
	self assert: file exists.
	output := file binaryReadStreamDo: [ :stream | stream upToEnd ].
	self assert: output equals: input
]

{ #category : #running }
GTEventRecorderFileStorageTest >> setUp [
	super setUp.
	fileSystem := FileSystem memory.
	storage := GTEventRecorderFileStorage new.
	storage directory: fileSystem workingDirectory.
]

{ #category : #tests }
GTEventRecorderFileStorageTest >> testAtCategoryPut [
	| location input category |
	input := #[1 2 3 4].
	category := 'category1'.
	location := storage atCategory: category put: input.
	self assertLocation: location input: input
]

{ #category : #tests }
GTEventRecorderFileStorageTest >> testDirectory [
	self assert: storage directory exists.
	self assert: storage directory isWritable.
]

{ #category : #tests }
GTEventRecorderFileStorageTest >> testPut [
	| location input |
	input := #[ 1 2 3 4 ].
	location := storage put: input.
	self assertLocation: location input: input
]
