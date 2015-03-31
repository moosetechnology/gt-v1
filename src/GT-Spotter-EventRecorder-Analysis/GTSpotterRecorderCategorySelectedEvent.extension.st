Extension { #name : #GTSpotterRecorderCategorySelectedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> elementSelectionEvents [
	^ self infoAt: #selectedElementEvents ifAbsent: [ #() ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Category: '.
	self categoryLabel
		ifNil: [ aStream nextPutAll: 'unknown category' ]
		ifNotNil: [ :aString |
			aStream 
				nextPutAll: aString;
				nextPutAll: ' with ';
				print: self elementCountOrZero;
				nextPutAll: ' elements' ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> markAsStrange [
	^ self infoAt: #strange put: true
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderCategorySelectedEvent >> selectedElementEvent: anEvent [
	| elements |
	elements := self infoAt: #selectedElementEvents ifAbsentPut: [ OrderedCollection new ].
	elements add: anEvent
]
