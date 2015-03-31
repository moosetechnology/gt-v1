Extension { #name : #GTSpotterRecorderSelectedCandidateChangedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> categoryEvent [
	^ self infoAt: #selectedCategoryEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Selection: '.
	self elementNamePrintOn: aStream.
	self eventTypePrintOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> selectedCategoryEvent: anEvent [
	self infoAt: #selectedCategoryEvent put: anEvent
]
