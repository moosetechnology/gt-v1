Extension { #name : #GTSpotterRecorderDiveInElementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> addSameLevelEvent: anEvent [ 
	| events |
	events := self infoAt: #sameLevelEvents ifAbsentPut: [ OrderedCollection new ].
	events add: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> childDiveInEvent: aDiveInEvent [ 
	| dives |
	dives := self infoAt: #childrenDiveInEvents ifAbsentPut: [ OrderedCollection new ].
	dives add: aDiveInEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> diveOutEvent: aGTSpotterRecorderDiveOutEvent [ 
	self infoAt: #diveOutEvent put: aGTSpotterRecorderDiveOutEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Dive In Element: '.
	self elementNamePrintOn: aStream.
	self eventTypePrintOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> parentDiveInEvent: aDiveInEvent [ 
	self infoAt: #parentDiveInEvent put: aDiveInEvent
]
