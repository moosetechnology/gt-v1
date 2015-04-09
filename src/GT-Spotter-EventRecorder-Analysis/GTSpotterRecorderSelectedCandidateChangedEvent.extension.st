Extension { #name : #GTSpotterRecorderSelectedCandidateChangedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> analysisIcon [
	^ GTSpotterEventIcons selectedCandidateChangedIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> categoryEvent [
	^ self infoAt: #selectedCategoryEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Selection: '.
	self elementNamePrintOn: aStream.
	self eventTypePrintOn: aStream.
	self selectedCategoryLabel ifNotNil: [ :aLabelString |
		aStream
			nextPutAll: ', in category ';
			nextPutAll: aLabelString ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> isForTimelineView [
	^ self isUserSelection
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> selectedCategoryEvent [
	^ self infoAt: #selectedCategoryEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> selectedCategoryEvent: anEvent [
	self infoAt: #selectedCategoryEvent put: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSelectedCandidateChangedEvent >> selectedCategoryLabel [
	^ self selectedCategoryEvent ifNotNil: [ :catEvent | catEvent categoryLabel ]
]
