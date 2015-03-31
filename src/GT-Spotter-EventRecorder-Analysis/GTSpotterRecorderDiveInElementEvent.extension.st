Extension { #name : #GTSpotterRecorderDiveInElementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> addSameLevelEvent: anEvent [ 
	| events |
	events := self infoAt: #sameLevelEvents ifAbsentPut: [ OrderedCollection new ].
	events add: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Dive In Element: '.
	self elementNamePrintOn: aStream.
	self eventTypePrintOn: aStream.
]
