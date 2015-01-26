Extension { #name : #CompiledMethod }

{ #category : #'*GT-Spotter' }
CompiledMethod >> spotterPreviewIn: aComposite [

	aComposite pharoMethod
		title: 'Preview';
		display: [:compiledMethod | 
			' ', compiledMethod getSource];
		smalltalkClass: #methodClass;
		entity: self.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]
