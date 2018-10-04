"
A RAObjectToFileStorageTest is a test class for testing the behavior of RAObjectToFileStorage
"
Class {
	#name : #GTSpotterRecorderObjectToFileStorageTest,
	#superclass : #TestCase,
	#instVars : [
		'storage',
		'fileSystem'
	],
	#category : #'GT-Spotter-EventRecorder-Server-Tests'
}

{ #category : #running }
GTSpotterRecorderObjectToFileStorageTest >> setUp [
	super setUp.
	fileSystem := FileSystem memory.
	storage := GTSpotterRecorderObjectToFileStorage on: fileSystem workingDirectory.
]

{ #category : #running }
GTSpotterRecorderObjectToFileStorageTest >> tearDown [
	fileSystem close.
	super tearDown.

]

{ #category : #tests }
GTSpotterRecorderObjectToFileStorageTest >> testAtPut [
	| uuid input output |
	uuid := UUID new asString.
	input := #[ 1 2 3 4 ].
	storage at: uuid put: input.
	output := storage at: uuid.
	self assert: output equals: input.

]

{ #category : #tests }
GTSpotterRecorderObjectToFileStorageTest >> testAtPut2 [
	| uuid input output |
	uuid := UUID new asString.
	input := #[ 1 2 3 4 ].
	storage at: uuid put: input.
	output := storage at: uuid.
	self assert: output equals: input.

	input := #[ 5 6 ].
	storage at: uuid put: input.
	output := storage at: uuid.
	self assert: output equals: input.
]

{ #category : #tests }
GTSpotterRecorderObjectToFileStorageTest >> testDirectory [
	self assert: storage directory exists.
	self assert: storage directory isWritable.
]
