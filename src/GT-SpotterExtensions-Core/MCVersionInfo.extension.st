Extension { #name : #MCVersionInfo }

{ #category : #'*GT-SpotterExtensions-Core-private' }
MCVersionInfo >> allAncestors [
	^ OrderedCollection streamContents: [ :stream |
		self allAncestorsDo: [ :versionInfo | 
			stream nextPut: versionInfo ] ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCVersionInfo >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCVersionInfo >> spotterAncestorsFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Ancestors';
		allCandidates: [ self allAncestors ];
		filter: GTFilterSubstring
]
