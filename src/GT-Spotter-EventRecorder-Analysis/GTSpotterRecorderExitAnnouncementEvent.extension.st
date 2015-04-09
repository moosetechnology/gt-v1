Extension { #name : #GTSpotterRecorderExitAnnouncementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> analysisIcon [
	^ GTSpotterEventIcons exitIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Close Spotter'
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> isForTimelineView [
	^ true
]
