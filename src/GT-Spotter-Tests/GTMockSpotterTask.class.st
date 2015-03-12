Class {
	#name : #GTMockSpotterTask,
	#superclass : #GLMAsyncTask,
	#category : #'GT-Spotter-Tests-Scripting-Mocks'
}

{ #category : #public }
GTMockSpotterTask >> execute: aBlock withArguments: aCollection callback: callbackBlock priority: aPriority delay: anIntegerMilliseconds [
	" we cannot handle asynchronous processes well in tests, so just execute is synchronously "
	aBlock valueWithPossibleArgs: aCollection.
	aCollection value.
]
