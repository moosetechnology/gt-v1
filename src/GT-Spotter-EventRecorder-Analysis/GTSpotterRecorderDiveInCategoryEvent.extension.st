Extension { #name : #GTSpotterRecorderDiveInCategoryEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> addSameLevelEvent: anEvent [ 
	| events |
	events := self infoAt: #sameLevelEvents ifAbsentPut: [ OrderedCollection new ].
	events add: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> childDiveInEvent: aDiveInEvent [ 
	| dives |
	dives := self infoAt: #childrenDiveInEvents ifAbsentPut: [ OrderedCollection new ].
	dives add: aDiveInEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> diveOutEvent: aGTSpotterRecorderDiveOutEvent [ 
	self infoAt: #diveOutEvent put: aGTSpotterRecorderDiveOutEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Dive In Category: '.
	self categoryTitle
		ifNil: [ aStream nextPutAll: 'unknown category' ]
		ifNotNil: [ :aString | 
			aStream nextPutAll: aString ].
	self eventTypePrintOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> parentDiveInEvent: aDiveInEvent [ 
	self infoAt: #parentDiveInEvent put: aDiveInEvent
]
