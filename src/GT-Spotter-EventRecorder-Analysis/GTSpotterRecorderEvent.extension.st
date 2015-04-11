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
GTSpotterRecorderEvent >> diveInLevel [
	^ self parentEvent 
		ifNotNil: [ :obj | obj diveInLevel + 1 ]
		ifNil: [ 1 ]
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
GTSpotterRecorderEvent >> followingDifferentTime [
	^ self infoAt: #followingDifferentTime ifAbsent: [ self timestampWithFixedTimeZone ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> isForTimelineView [
	^ false
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
GTSpotterRecorderEvent >> myPositionAmongSameTimeEvents [
	^ self infoAt: #myPositionAmongSameTimeEvents ifAbsent: [ 1 ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> parentEvent [
	^ self infoAt: #diveInEvent ifPresent: [ :obj | obj ] ifAbsent: [ nil ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> relativeXPosition [
	^ self infoAt: #relativeXPosition
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> relativeXPosition: aDateAndTime [ 
	^ self infoAt: #relativeXPosition put: aDateAndTime
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
GTSpotterRecorderEvent >> removeSameTimeEvents [
	self removeInfoKey: #sameTimeEvents.
	self removeInfoKey: #myPositionAmongSameTimeEvents.
	self removeInfoKey: #followingDifferentTime.
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
GTSpotterRecorderEvent >> sameTimeEvents [
	^ self infoAt: #sameTimeEvents ifAbsent: [ #() ].
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> sameTimeEvents: aCollection index: anInteger nextDateAndTime: aDateAndTime [ 
	self infoAt: #sameTimeEvents put: aCollection.
	self infoAt: #myPositionAmongSameTimeEvents put: anInteger.
	self infoAt: #followingDifferentTime put: aDateAndTime.
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
	self infoAt: #timestampWithFixedTimeZone ifPresent: [ :value | ^ value ] ifAbsent: [ "ignore" ].
	dateAndTime := self dateAndTime.
	dateAndTime ifNil: [ ^ nil ].
	announcementTimestamp := self announcementTimestamp.
	announcementTimestamp ifNil: [ 
		^ self 
			infoAt: #timestampWithFixedTimeZone 
			put: (dateAndTime translateTo: 0) ].
	dateAndTime asDate = announcementTimestamp asDate ifTrue: [ 
		^ self 
			infoAt: #timestampWithFixedTimeZone 
			put: (dateAndTime translateTo: announcementTimestamp offset) ].
	session := self session.
	session ifNil: [ 
		^ self 
			infoAt: #timestampWithFixedTimeZone 
			put: (dateAndTime translateTo: announcementTimestamp offset) ].
	dates := (session collect: #announcementTimestamp as: Set)
		select: [ :eachTimestamp | eachTimestamp asDate yyyymmdd = dateAndTime asDate yyyymmdd ].
	dates ifEmpty: [ 
		^ self 
			infoAt: #timestampWithFixedTimeZone 
			put: (dateAndTime translateTo: announcementTimestamp offset) ].
	^ self 
		infoAt: #timestampWithFixedTimeZone 
		put: (dateAndTime translateTo: dates any offset)
]
