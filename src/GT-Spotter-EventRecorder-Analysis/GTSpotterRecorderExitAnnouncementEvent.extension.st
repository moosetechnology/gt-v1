Extension { #name : #GTSpotterRecorderExitAnnouncementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> analysisIcon [
	^ GTSpotterEventIcons exitIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'Close Spotter on category ';
		nextPutAll: self selectedCategoryLabel.
	self eventTypePrintOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> isForTimelineView [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> removeSelectedElementEvent [
	^ self removeInfoKey: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> selectedCategoryLabel [
	^ self selectedElementEvent selectedCategoryLabel
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> selectedElementEvent [
	^ self infoAt: #selectedElementEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderExitAnnouncementEvent >> selectedElementEvent: anEvent [
	^ self infoAt: #selectedElementEvent put: anEvent
]
