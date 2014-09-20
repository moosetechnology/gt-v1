Extension { #name : #FileReference }

{ #category : #'*GT-InspectorExtensions-Core' }
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

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference class >> gtExampleGif [
	<gtExample>
	^ FileSystem memory workingDirectory / 'pharoicon.gif' 
		writeStreamDo: [ :stream |
			GIFReadWriter 
				putForm: ThemeIcons current pharoIcon 
				onStream: stream ];
		yourself
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference class >> gtExamplePng [
	<gtExample>
	^ FileSystem memory workingDirectory / 'pharoicon.png' 
		writeStreamDo: [ :stream |
			PNGReadWriter 
				putForm: ThemeIcons current pharoIcon 
				onStream: stream ];
		yourself
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference class >> gtExampleText [
	<gtExample>
	^ FileSystem memory workingDirectory / 'sample.txt' 
		writeStreamDo: [ :stream |
			stream nextPutAll: self comment ];
		yourself
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference >> gtInspectorActionMaterializeFuel [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :composite | 
			| result |
			result := FLMaterializer materializeFromFileNamed: self fullName.
			composite selection: result ];
		icon: GLMUIThemeExtraIcons glamorousAdd;
		condition: [ self extension = 'fuel' ];
		title: 'Materialize'
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite rubricText
			title: 'Raw';
			display: [ 
				self readStreamDo: [ :stream | 
					| result |
					result := [(stream next: 10000) asString]
						on: Error 
						do: [ (stream binary next: 10000) asString ].
					stream size > 10000
						ifTrue: [ result, '  ... truncated ...' ]
						ifFalse: [ result ] ] ];
			withLineNumbers: true;
			when: [ self isFile ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference >> gtInspectorFuelIn: composite [
	<gtInspectorPresentationOrder: 40>
	"(FileSystem disk workingDirectory / 'GTtest.fuel') writeStreamDo: [ :stream |
	FLSerializer newDefault
		at: #author putAdditionalObject: 'Author: Max Leske';
		at: #date putAdditionalObject: DateAndTime now;
		addPreMaterializationAction: [ Smalltalk inform: 'starting materialization' ];
		addPostMaterializationAction: [ :materialization | materialization inspect ];
		serialize: 'foo' on: stream binary ].
	
FLMaterializer materializeFromFileNamed: 'GTtest.fuel'"
	composite table
			title: 'Fuel Header';
			display: [
				(FLMaterializer materializeHeaderFromFileNamed: self fullName) gtGetMetaData ];
			column: 'Property' evaluated: [:assoc| assoc key ];
			column: 'Value' evaluated: [:assoc| assoc value];
			when: [ self extension = 'fuel' ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference >> gtInspectorGifIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite morph
			title: 'Picture';
			display: [ self binaryReadStreamDo: [ :stream | GIFReadWriter formFromStream: stream ] ];
			when: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imageGif ] ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite table 
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
		column: 'Name' evaluated: [:each | (self isChildOf: each) 
								ifTrue: [ '..' ] 
								ifFalse: [ each basename ]] width: 400;
		column: 'Size' evaluated: [:each | each humanReadableSize] width: 100;
		column: 'Creation' evaluated: [ :each | 
			String streamContents: [:s | 
				each creationTime printYMDOn: s.
				s nextPut: Character space.
				each creationTime printHMSOn: s ]];
		icon: [ :each | 
			each isDirectory 
				ifTrue: [ GLMUIThemeExtraIcons glamorousFolder ] 
				ifFalse: [ GLMUIThemeExtraIcons glamorousBrowse ] ];
		when: [self isDirectory and: [self hasChildren]];
		selectionAct: [:table | table selection delete. table update] entitled: 'Delete';
		act: [ :table | table update ] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Refresh'
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference >> gtInspectorJpegIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite morph
			title: 'Picture';
			display: [ self binaryReadStreamDo: [ :stream | JPEGReadWriter formFromStream: stream ] ];
			when: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imageJpeg ] ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference >> gtInspectorPngIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite morph
			title: 'Picture';
			display: [ self binaryReadStreamDo: [ :stream | PNGReadWriter formFromStream: stream ] ];
			when: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imagePng ] ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileReference >> gtInspectorStScriptIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite smalltalkCode
			title: 'Script';
			display: [ self readStreamDo: [ :s | s contents ] ];
			selectionPopulate: #selection
				on: $o
				entitled: 'Do it and open (o)'
				with: [ :text :object | 
					Compiler evaluate: text selectedText for: object logged: false ];
			act: [ :text |
				self ensureDelete; writeStreamDo: [ :s | s nextPutAll: text text asString ] ]
				icon: GLMUIThemeExtraIcons glamorousSave
				on: $s
				entitled: 'Save';
			when: [ self extension = 'st' ]
]
