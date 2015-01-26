Extension { #name : #RPackage }

{ #category : #'*GT-Spotter' }
RPackage >> spotterPreviewIn: aComposite [

	aComposite list
		title: 'Preview';
		display: [ :x | x ];
		format: [ :class | GTSpotterItemBrick new text: class gtDisplayString; icon: class systemIcon; disable; yourself ];
		entity: self classes asArray.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]
