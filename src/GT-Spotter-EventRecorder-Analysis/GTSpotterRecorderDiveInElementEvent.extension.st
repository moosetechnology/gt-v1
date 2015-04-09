Extension { #name : #GTSpotterRecorderDiveInElementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> addSameLevelEvent: anEvent [ 
	| events |
	events := self infoAt: #sameLevelEvents ifAbsentPut: [ OrderedCollection new ].
	events add: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> analysisIcon [
	^ GTSpotterEventIcons diveInElementIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> duration [
	^ (self children max: #timestamp) - self timestamp 
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> eventAnalysisPrintOn: aStream [
	self isMissStep ifTrue: [ aStream nextPutAll: 'MissStep ' ].
	aStream nextPutAll: 'Dive In Element for '.
	aStream 
		print: self duration;
		nextPutAll: ': '.
	self elementNamePrintOn: aStream.
	self eventTypePrintOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> hasDiveIn [
	^ self children contains: #isDiveIn 
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> hasQuery [
	^ self children contains: #isContextChanged
]
