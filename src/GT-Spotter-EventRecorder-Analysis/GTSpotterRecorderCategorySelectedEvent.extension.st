Extension { #name : #GTSpotterRecorderCategorySelectedEvent }

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
