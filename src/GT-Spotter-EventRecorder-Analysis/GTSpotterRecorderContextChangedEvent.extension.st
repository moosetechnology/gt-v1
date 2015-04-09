Extension { #name : #GTSpotterRecorderContextChangedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> analysisIcon [
	^ GTSpotterEventIcons contextChangedIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Context Change: '.
	self currentTextHashes 
			ifEmpty: [ aStream nextPutAll: 'no input' ]
			ifNotEmpty: [ :aCollection | 
				aStream 
					print: aCollection size;
					nextPutAll: ' words' ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> isForTimelineView [
	^ self isContextChanged
]
