Extension { #name : #GTSpotterRecorderSearchFinishedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'SearchFinished: ';
		nextPutAll: (query ifNil: [ 'no query' ] ifNotNil: [ 'with query' ]);
		nextPutAll: ', ';
		print: self categories size;
		nextPutAll: ' categories, ';
		print: (self items ifEmpty: [ 0 ] ifNotEmpty: [ :col | col sum ]);
		nextPutAll: ' findings'
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> isForTimelineView [
	^ true
]
