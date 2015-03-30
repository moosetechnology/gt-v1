Extension { #name : #GTSpotterRecorderExitAnnouncementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Close Spotter'
]
