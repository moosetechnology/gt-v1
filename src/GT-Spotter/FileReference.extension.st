Extension { #name : #FileReference }

{ #category : #'*GT-Spotter' }
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

{ #category : #'*GT-Spotter' }
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
