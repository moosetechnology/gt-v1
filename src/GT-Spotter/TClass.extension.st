Extension { #name : #TClass }

{ #category : #'*GT-Spotter' }
TClass >> spotterPreviewIn: aComposite [

	aComposite pharoMethod
		title: 'Preview';
		display: #definitionForNautilus;
		smalltalkClass: [ nil ];
		entity: self.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]
