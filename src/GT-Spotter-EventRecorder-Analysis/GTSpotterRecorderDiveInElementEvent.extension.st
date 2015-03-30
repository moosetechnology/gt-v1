Extension { #name : #GTSpotterRecorderDiveInElementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Dive In Element: '.
	self elementNamePrintOn: aStream.
	self eventTypePrintOn: aStream.
]
