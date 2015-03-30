Extension { #name : #GTSpotterRecorderDiveOutEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Dive Out: '.
	self elementNamePrintOn: aStream.

]
