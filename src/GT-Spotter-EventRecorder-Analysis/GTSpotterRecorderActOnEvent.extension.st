Extension { #name : #GTSpotterRecorderActOnEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Act On: '.
	self elementNamePrintOn: aStream.
	self eventTypePrintOn: aStream.
]
