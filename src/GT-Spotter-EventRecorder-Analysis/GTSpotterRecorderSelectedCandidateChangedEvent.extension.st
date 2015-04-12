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
	aStream nextPutAll: 'Selection of '.
	self elementNamePrintOn: aStream.
	self selectedCategoryLabel ifNotNil: [ :aLabelString |
		aStream
			nextPutAll: ' in category ';
			nextPutAll: aLabelString ].
	self eventTypePrintOn: aStream.

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
