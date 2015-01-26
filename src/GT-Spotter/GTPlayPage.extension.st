Extension { #name : #GTPlayPage }

{ #category : #'*GT-Spotter' }
GTPlayPage >> spotterPreviewIn: aComposite [

	aComposite pharoMethod
		title: 'Preview';
		display: #content;
		smalltalkClass: [ nil ];
		entity: self.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]
