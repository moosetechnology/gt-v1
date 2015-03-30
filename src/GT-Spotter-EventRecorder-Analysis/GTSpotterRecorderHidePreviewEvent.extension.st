Extension { #name : #GTSpotterRecorderHidePreviewEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderHidePreviewEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Hide Preview'
]
