Extension { #name : #GTSpotterRecorderDiveInElementEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> addSameLevelEvent: anEvent [ 
	| events |
	events := self infoAt: #sameLevelEvents ifAbsentPut: [ OrderedCollection new ].
	events add: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> analysisIcon [
	^ self isMissStep 
			ifFalse: [ GTSpotterEventIcons diveInElementIcon ]
			ifTrue: [ GTSpotterEventIcons diveInElementMissStepIcon ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> duration [
	self children ifEmpty: [ ^ 0 seconds ].
	^ (self children last dateAndTime) - self dateAndTime 
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

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> isForTimelineView [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInElementEvent >> userQueryOrSelectionHashes [
	^ self elementName 
			ifNil: [ #() ]
			ifNotNil: [ :value | Array with: value ]
]
