Extension { #name : #GTPlayPage }

{ #category : #'*GT-SpotterExtensions-Core' }
GTPlayPage >> spotterActDefault [
	^ GTPlayground new openOn: self
]

{ #category : #'*GT-SpotterExtensions-Core' }
GTPlayPage >> spotterPreviewCodeIn: aComposite [
	<spotterPreview: 10>
	aComposite pharoMethod
		title: 'Preview';
		display: #content;
		smalltalkClass: [ nil ];
		entity: self.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]
