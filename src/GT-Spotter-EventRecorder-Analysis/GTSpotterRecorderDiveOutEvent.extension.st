Extension { #name : #GTSpotterRecorderDiveOutEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Dive Out: '.
	self elementNamePrintOn: aStream.

]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveOutEvent >> parentDiveInEvent: aDiveInEvent [ 
	self infoAt: #parentDiveInEvent put: aDiveInEvent
]
