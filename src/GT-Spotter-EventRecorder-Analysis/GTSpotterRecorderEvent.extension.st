Extension { #name : #GTSpotterRecorderEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> analysisIcon [
	^ GTSpotterEventIcons noIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> asEventAnalysisString [
	^ String streamContents: [ :stream |
			self eventAnalysisPrintOn: stream ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> children [
	^ self infoAt: #sameLevelEvents ifAbsent: [ #() ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> cleanDiveInEvent: aDiveInEvent [ 
	^ self removeInfoAt: #diveInEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> diveInEvent: aDiveInEvent [ 
	^ self infoAt: #diveInEvent put: aDiveInEvent.
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

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isMissStep [
	^ self infoAt: #isMissStep ifPresent: [ :obj | true ] ifAbsent: [ false ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isRootEvent [
	^ self infoAt: #diveInEvent ifPresent: [ :obj | false ] ifAbsent: [ true ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isStrange [
	^ self infoAt: #strange ifPresent: [ :aCol | aCol notEmpty ] ifAbsent: [ false ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> markAsStrange: aString [
	| stranges |
	stranges := self infoAt: #strange ifAbsentPut: [ OrderedCollection new ].
	stranges add: aString.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeDiveInEvent [
	^ self removeInfoKey: #diveInEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeIsMissStep [
	^ self removeInfoKey: #isMissStep
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeSameLevelEvents [
	^ self removeInfoKey: #sameLevelEvents
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeSelectedCategoryEvent [
	^ self removeInfoKey: #selectedCategoryEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeSelectedElementEvents [
	^ self removeInfoKey: #selectedElementEvents
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeSession [
	^ self removeInfoKey: #session
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> removeStrange [
	^ self removeInfoKey: #strange
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> session [
	^ self infoAt: #session
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> session: aSessionCollection [ 
	^ self infoAt: #session put: aSessionCollection.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> setMissStep [
	^ self infoAt: #isMissStep put: true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> strange [
	^ self infoAt: #strange ifAbsent: [ #() ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> timestampWithFixedTimeZone [
	| dateAndTime announcementTimestamp session dates |
	timestamp ifNil: [ ^ nil ].
	dateAndTime := DateAndTime fromUnixTime: timestamp.
	announcementTimestamp := self announcementTimestamp.
	announcementTimestamp ifNil: [ ^ dateAndTime translateTo: 0 ].
	dateAndTime asDate = announcementTimestamp asDate ifTrue: [ 
		^ dateAndTime translateTo: announcementTimestamp offset ].
	session := self session.
	session ifNil: [ ^ dateAndTime translateTo: announcementTimestamp offset ].
	dates := (session collect: #announcementTimestamp as: Set)
		select: [ :eachTimestamp | eachTimestamp asDate yyyymmdd = dateAndTime asDate yyyymmdd ].
	dates ifEmpty: [ ^ dateAndTime translateTo: announcementTimestamp offset ].
	^ dateAndTime translateTo: dates any offset
]
