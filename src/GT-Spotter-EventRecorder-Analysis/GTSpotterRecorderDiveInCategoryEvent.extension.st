Extension { #name : #GTSpotterRecorderDiveInCategoryEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderDiveInCategoryEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Dive In Category: '.
	self categoryTitle
		ifNil: [ aStream nextPutAll: 'unknown category' ]
		ifNotNil: [ :aString | 
			aStream nextPutAll: aString ].
	self eventTypePrintOn: aStream.
]
