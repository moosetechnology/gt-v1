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
