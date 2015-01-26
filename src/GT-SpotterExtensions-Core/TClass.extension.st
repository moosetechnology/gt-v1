Extension { #name : #TClass }

{ #category : #'*GT-SpotterExtensions-Core' }
TClass >> spotterMethodsFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			title: 'Instance methods';
			allCandidates: [ self methods ];
			itemName: [ :method | method selector ];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TClass >> spotterPreviewIn: aComposite [

	aComposite pharoMethod
		title: 'Preview';
		display: #definitionForNautilus;
		smalltalkClass: [ nil ];
		entity: self.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]

{ #category : #'*GT-SpotterExtensions-Core' }
TClass >> spotterReferenceFor: aStep [
	<spotterOrder: 30>
	aStep listProcessor
			title: 'References';
			allCandidates: [ (SystemNavigation default allReferencesTo: self binding) collect: #compiledMethod ];
			itemName: [ :method | method gtDisplayString ];
			matchSubstring
]
