Extension { #name : #GTSpotterRecorderShowPreviewEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderShowPreviewEvent >> analysisIcon [
	^ GTSpotterEventIcons showPreviewIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderShowPreviewEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Show Preview'
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderShowPreviewEvent >> isForTimelineView [
	^ true
]
