Extension { #name : #XMLNodeWithElements }

{ #category : #'*GT-SpotterExtensions-XML' }
XMLNodeWithElements >> spotterForChildrenIn: aStep [
	<spotterOrder: 10>
	aStep listProcessor
		title: 'Children';
		allCandidates: [ self elements ]
]

{ #category : #'*GT-SpotterExtensions-XML' }
XMLNodeWithElements >> spotterForPastellIn: aStep [
	<spotterOrder: 10>
	aStep listProcessor
		title: 'Pastell';
		filter: [ :context | 
			| result |
			result := (self // context textTrimmed) asOrderedCollection.
			context addItems: result.
			result ]
]

{ #category : #'*GT-SpotterExtensions-XML' }
XMLNodeWithElements >> spotterSourceIn: composite [
	<spotterPreview: 10>
	composite text 
		title: [ '/' join: (self ancestorNodes collect: #gtName) ];
		display: #yourself;
		entity: self prettyPrinted
]
