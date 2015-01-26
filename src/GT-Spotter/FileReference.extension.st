Extension { #name : #FileReference }

{ #category : #'*GT-Spotter' }
FileReference >> spotterPreviewIn: aComposite [

	self isDirectory ifFalse: [ ^ super spotterPreviewIn: aComposite ].
	aComposite list
		title: 'Preview';
		display: #basename;
		format: [ :folder | GTSpotterItemBrick new text: folder; icon: GLMUIThemeExtraIcons glamorousFolder; disable; yourself ];
		styled: [ :brick | brick ];
		entity: self directories.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]
