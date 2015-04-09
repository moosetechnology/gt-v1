Extension { #name : #GTSpotterRecorderDiveOutEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> analysisIcon [
	^ GTSpotterEventIcons diveOutIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Dive Out: '.
	self elementNamePrintOn: aStream.

]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> isForTimelineView [
	^ true
]
