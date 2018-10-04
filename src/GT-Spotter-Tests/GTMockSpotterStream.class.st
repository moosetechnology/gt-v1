Class {
	#name : #GTMockSpotterStream,
	#superclass : #GTSpotterUIThreadStream,
	#category : #'GT-Spotter-Tests-Scripting-Mocks'
}

{ #category : #performing }
GTMockSpotterStream >> performSymbol: aSymbol withArguments: aCollection [
	self receiver perform: aSymbol withEnoughArguments: aCollection
]
