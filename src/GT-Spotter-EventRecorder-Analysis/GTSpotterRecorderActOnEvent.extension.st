Extension { #name : #GTSpotterRecorderActOnEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> analysisIcon [
	^ GTSpotterEventIcons actOnIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Act On: '.
	self elementNamePrintOn: aStream.
	self eventTypePrintOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> hasKnownName [
	"It is a hash"
	^ self elementName notNil
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> hasName [
	"It is a hash"
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> isActOn [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> isForTimelineView [
	^ true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderActOnEvent >> userQueryOrSelectionHashes [
	^ self elementName 
			ifNil: [ #() ]
			ifNotNil: [ :value | Array with: value ]
]
