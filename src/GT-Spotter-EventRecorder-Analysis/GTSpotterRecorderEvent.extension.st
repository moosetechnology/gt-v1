Extension { #name : #GTSpotterRecorderEvent }

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
GTSpotterRecorderEvent >> removeStrange [
	^ self removeInfoKey: #strange
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> setMissStep [
	^ self infoAt: #isMissStep put: true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderEvent >> strange [
	^ self infoAt: #strange ifAbsent: [ #() ].
]
