Extension { #name : #GTSpotterRecorderEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> asEventAnalysisString [
	^ String streamContents: [ :stream |
			self eventAnalysisPrintOn: stream ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> elementNamePrintOn: aStream [
	self elementName 
		ifNil: [ aStream nextPutAll: 'unknown element' ];
		ifNotNil: [ aStream nextPutAll: 'an element' ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> eventAnalysisPrintOn: aStream [
	self printOn: aStream
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> eventTypePrintOn: aStream [
	self eventType
		ifNotNil: [ :aSymbol |
			aStream
				nextPut: $,; 
				space;
				print: aSymbol;
				nextPutAll: ' event' ]
]
