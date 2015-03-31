Class {
	#name : #GTSpotterAnalysisCommand,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #'instance creation' }
GTSpotterAnalysisCommand class >> context: aGTSpotterSession [ 
	^ self new context: aGTSpotterSession; yourself
]

{ #category : #accessing }
GTSpotterAnalysisCommand >> context [
	^ context
]

{ #category : #accessing }
GTSpotterAnalysisCommand >> context: anObject [
	context := anObject
]

{ #category : #execute }
GTSpotterAnalysisCommand >> execute [
	self subclassResponsibility
]

{ #category : #accessing }
GTSpotterAnalysisCommand >> session [
	^ self context session
]
