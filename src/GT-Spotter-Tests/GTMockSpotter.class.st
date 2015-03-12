Class {
	#name : #GTMockSpotter,
	#superclass : #GTSpotter,
	#category : #'GT-Spotter-Tests-Scripting-Mocks'
}

{ #category : #'accessing-defaults' }
GTMockSpotter >> defaultPagerModel [
	^ GLMMockPagerModel new
]

{ #category : #'accessing-defaults' }
GTMockSpotter >> defaultStep [
	^ GTMockSpotterStep new
]
