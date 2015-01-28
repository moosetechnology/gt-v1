Extension { #name : #FileReference }

{ #category : #'*GT-SpotterExtensions-Core' }
FileReference >> spotterForDirectoriesFor: aStep [
	<spotterOrder: 10>
	^ self isDirectory ifTrue: [
		aStep listProcessor
			allCandidates: [ self directories ];
			title: 'Directories';
			itemName: #basename;
			itemIcon: [ GLMUIThemeExtraIcons glamorousFolder ];
			matchSubstring ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
FileReference >> spotterForFilesFor: aStep [
	<spotterOrder: 20>
	^ self isDirectory ifTrue: [
		aStep listProcessor
			allCandidates: [ self files ];
			title: 'Files';
			itemName: #basename;
			itemIcon: [ GLMUIThemeExtraIcons glamorousBrowse ];
			matchSubstring ]
]

{ #category : #'*GT-SpotterExtensions-Core' }
FileReference >> spotterPreviewContentsIn: aComposite [
	<spotterPreview: 20>
	
	self isFile ifFalse: [ ^ self ].
	aComposite custom: 
		(RubScrolledTextMorph new
			setTextWith: (self readStreamDo: [ :stream | 
					| result |
					result := [(stream next: 10000) asString]
						on: Error 
						do: [ (stream binary next: 10000) asString ].
					stream size > 10000
						ifTrue: [ result, '  ... truncated ...' ]
						ifFalse: [ result ] ]) )
]

{ #category : #'*GT-SpotterExtensions-Core' }
FileReference >> spotterPreviewItemsIn: aComposite [
	<spotterPreview: 10>
	
	self isDirectory ifFalse: [ ^ self ].
	aComposite list
		title: [ self gtDisplayString ];
		display: #yourself;
		format: [ :folder | 
			GTSpotterItemBrick new 
				text: folder basename; 
				icon: (folder isDirectory 
								ifTrue: [Smalltalk ui theme icons glamorousFolder]
								ifFalse: [Smalltalk ui theme icons glamorousBrowse] ); 
				disable; 
				yourself ];
		styled: [ :brick | brick ];
		entity: self directories, self files.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]

{ #category : #'*GT-SpotterExtensions-Core' }
FileReference >> spotterPreviewPngIn: aComposite [
	<spotterPreview: 10>
	
	(self mimeTypes notNil and: [ 
		self mimeTypes first matches: ZnMimeType imagePng ]) 
		ifFalse: [ ^ self ].
	aComposite custom: 
		((self binaryReadStreamDo: [ :stream | PNGReadWriter formFromStream: stream ])
			asAlphaImageMorph asBrick margin: 20)
]
