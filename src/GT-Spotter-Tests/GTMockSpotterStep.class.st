Class {
	#name : #GTMockSpotterStep,
	#superclass : #GTSpotterStep,
	#category : #'GT-Spotter-Tests-Scripting-Mocks'
}

{ #category : #'accessing-defaults' }
GTMockSpotterStep >> defaultStream [
	^ GTMockSpotterStream new
]

{ #category : #'accessing-defaults' }
GTMockSpotterStep >> defaultTask [
	^ GTMockSpotterTask new
]
