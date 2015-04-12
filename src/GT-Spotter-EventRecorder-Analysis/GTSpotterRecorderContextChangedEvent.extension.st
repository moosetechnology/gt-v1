Extension { #name : #GTSpotterRecorderContextChangedEvent }

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> analysisIcon [
	^ GTSpotterEventIcons contextChangedIcon
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> eventAnalysisPrintOn: aStream [
	aStream nextPutAll: 'Context Change: '.
	self currentTextSizes 
			ifEmpty: [ aStream nextPutAll: 'no input' ]
			ifNotEmpty: [ :aCollection | 
					aStream
						print: aCollection size;
						nextPutAll: (aCollection size = 1 
											ifTrue: [ ' word of size ' ] 
											ifFalse: [ ' words, each of size: ' ]).
				aCollection 
					do: [ :eachSize | aStream print: eachSize ] 
					separatedBy: [ aStream space ].
				self hasCurrentTextSpecials ifTrue: [ 
					aStream nextPutAll: ', with #keyword' ] ]
]

{ #category : #'*GT-Spotter-EventRecorder-Analysis' }
GTSpotterRecorderContextChangedEvent >> isForTimelineView [
	^ self isContextChanged
]
