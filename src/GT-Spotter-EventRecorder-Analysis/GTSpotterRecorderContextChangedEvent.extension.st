Extension { #name : #GTSpotterRecorderContextChangedEvent }

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
