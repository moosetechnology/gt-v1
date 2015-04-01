Extension { #name : #GTSpotterRecorderSearchFinishedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderSearchFinishedEvent >> eventAnalysisPrintOn: aStream [
	aStream
		nextPutAll: 'SearchFinished: ';
		nextPutAll: (query ifNil: [ 'no query' ] ifNotNil: [ 'with query' ]);
		nextPutAll: ', ';
		print: self categories size;
		nextPutAll: ' categories, ';
		print: self items sum;
		nextPutAll: ' findings'
]