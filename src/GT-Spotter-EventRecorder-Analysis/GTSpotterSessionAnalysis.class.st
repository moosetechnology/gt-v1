Class {
	#name : #GTSpotterSessionAnalysis,
	#superclass : #Object,
	#instVars : [
		'session'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #api }
GTSpotterSessionAnalysis class >> executeOn: aGTSpotterSession [
	^ (self session: aGTSpotterSession) execute
]

{ #category : #'instance creation' }
GTSpotterSessionAnalysis class >> session: aGTSpotterSession [ 
	^ self new session: aGTSpotterSession; yourself
]

{ #category : #execute }
GTSpotterSessionAnalysis >> execute [
	(GTSpotterAnalysisCommand allSubclasses 
		sort: [ :a :b | a analysisOrder < b analysisOrder ]) 
			do: [ :each | | command |
				command := each context: self.
				command execute ].
	^ self session
]

{ #category : #accessing }
GTSpotterSessionAnalysis >> session [
	^ session
]

{ #category : #accessing }
GTSpotterSessionAnalysis >> session: anObject [
	session := anObject
]
