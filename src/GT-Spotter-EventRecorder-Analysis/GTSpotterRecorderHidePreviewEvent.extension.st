Extension { #name : #GTSpotterRecorderHidePreviewEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderHidePreviewEvent >> analysisIcon [
	^ GTSpotterEventIcons hidePreviewIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderHidePreviewEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Hide Preview'
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderHidePreviewEvent >> isForTimelineView [
	^ true
]
