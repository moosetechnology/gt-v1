Extension { #name : #GTSpotterRecorderSelectedCandidateChangedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Selection: '.
	self elementNamePrintOn: aStream.
	self eventTypePrintOn: aStream.
]
