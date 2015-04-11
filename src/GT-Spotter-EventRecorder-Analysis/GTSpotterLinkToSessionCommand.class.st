Class {
	#name : #GTSpotterLinkToSessionCommand,
	#superclass : #GTSpotterAnalysisCommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTSpotterLinkToSessionCommand class >> analysisOrder [
	^ 1
]

{ #category : #execute }
GTSpotterLinkToSessionCommand >> clean [
	self session do: [ :eachEvent |
		eachEvent removeSession ]
]

{ #category : #execute }
GTSpotterLinkToSessionCommand >> execute [
	self session do: [ :eachEvent |
		eachEvent session: self session ]
]
