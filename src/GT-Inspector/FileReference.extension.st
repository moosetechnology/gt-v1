Extension { #name : #FileReference }

{ #category : #'*GT-Inspector' }
FileReference class >> gtExampleDirectory [
	<gtExample>
	| directory subDirectory |
	directory := FileSystem memory workingDirectory / 'directory'.
	directory createDirectory.
	directory / 'file1.txt' writeStreamDo: [ :stream | stream nextPutAll: 'File1 contents' ].
	directory / 'file2.txt' writeStreamDo: [ :stream | stream nextPutAll: 'File2 contents' ].
	subDirectory := (directory / 'subdirectory') createDirectory.
	subDirectory / 'file3.txt' writeStreamDo: [ :stream | stream nextPutAll: 'File3 contents' ].
	^ directory
]

{ #category : #'*GT-Inspector' }
FileReference class >> gtExampleGif [
	<gtExample>
	^ FileSystem memory workingDirectory / 'pharoicon.gif' 
		writeStreamDo: [ :stream |
			GIFReadWriter 
				putForm: ThemeIcons current pharoIcon 
				onStream: stream ];
		yourself
]

{ #category : #'*GT-Inspector' }
FileReference class >> gtExamplePng [
	<gtExample>
	^ FileSystem memory workingDirectory / 'pharoicon.png' 
		writeStreamDo: [ :stream |
			PNGReadWriter 
				putForm: ThemeIcons current pharoIcon 
				onStream: stream ];
		yourself
]

{ #category : #'*GT-Inspector' }
FileReference class >> gtExampleText [
	<gtExample>
	^ FileSystem memory workingDirectory / 'sample.txt' 
		writeStreamDo: [ :stream |
			stream nextPutAll: self comment ];
		yourself
]

{ #category : #'*gt-inspector' }
FileReference >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite rubricText
			title: 'Contents';
			display: [ 
				self readStreamDo: [ :stream | 
					| result |
					result := [(stream next: 5000) asString]
						on: Error 
						do: [ (stream binary next: 5000) asString ].
					stream size > 5000
						ifTrue: [ result, '  ... truncated ...' ]
						ifFalse: [ result ] ] ];
			withLineNumbers: true;
			when: [ self isFile ]
]

{ #category : #'*gt-inspector' }
FileReference >> gtInspectorGifIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite morph
			title: 'Morph';
			display: [ self binaryReadStreamDo: [ :stream | GIFReadWriter formFromStream: stream ] ];
			when: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imageGif ] ]
]

{ #category : #'*gt-inspector' }
FileReference >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite list 
		title: 'Items';
		display: [ 
			| children |
			children := self directories, self files.
			self isRoot 
				ifTrue: [ children ]
				ifFalse: [ 
					children asOrderedCollection 
						addFirst: self parent;
						yourself ] ];
		format: [:each | (self isChildOf: each) 
								ifTrue: [ '..' ] 
								ifFalse: [ each basename ]];
		icon: [ :each | 
			each isDirectory 
				ifTrue: [ GLMUIThemeExtraIcons glamorousOpen ] 
				ifFalse: [ GLMUIThemeExtraIcons glamorousBrowse ] ];
		when: [self isDirectory and: [self hasChildren]]
]

{ #category : #'*gt-inspector' }
FileReference >> gtInspectorJpegIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite morph
			title: 'Morph';
			display: [ self binaryReadStreamDo: [ :stream | JPEGReadWriter formFromStream: stream ] ];
			when: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imageJpeg ] ]
]

{ #category : #'*gt-inspector' }
FileReference >> gtInspectorPngIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite morph
			title: 'Morph';
			display: [ self binaryReadStreamDo: [ :stream | PNGReadWriter formFromStream: stream ] ];
			when: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imagePng ] ]
]
