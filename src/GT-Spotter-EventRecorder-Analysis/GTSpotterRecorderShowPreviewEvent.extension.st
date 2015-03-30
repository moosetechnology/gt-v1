Extension { #name : #GTSpotterRecorderShowPreviewEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderShowPreviewEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Show Preview'
]
