Extension { #name : #GTSpotterRecorderDiveInCategoryEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> addSameLevelEvent: anEvent [ 
	| events |
	events := self infoAt: #sameLevelEvents ifAbsentPut: [ OrderedCollection new ].
	events add: anEvent
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> duration [
	^ (self children max: #timestamp) - self timestamp 
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> eventAnalysisPrintOn: aStream [
	self isMissStep ifTrue: [ aStream nextPutAll: 'MissStep ' ].
	aStream nextPutAll: 'Dive In Category for '.
	aStream 
		print: self duration;
		nextPutAll: ': '.
	self categoryTitle
		ifNil: [ aStream nextPutAll: 'unknown category' ]
		ifNotNil: [ :aString | 
			aStream nextPutAll: aString ].
	self eventTypePrintOn: aStream.
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> hasDiveIn [
	^ self children contains: #isDiveIn 
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> hasQuery [
	^ self children contains: #isContextChanged
]
