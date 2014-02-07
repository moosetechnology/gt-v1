Extension { #name : #FileSystem }

{ #category : #'*GT-Inspector' }
FileSystem class >> gtExampleZip [
	<gtExample>
	| zipFile zip |
	zipFile := FileSystem memory workingDirectory / 'test.zip'.
	zip := (FileSystem zip: zipFile) open.
	zip / 'sample.txt'
		writeStreamDo: [ :stream |
				stream nextPutAll: self comment ];
			yourself.
	^ zip
]

{ #category : #'*GT-Inspector' }
FileSystem >> gtInspectorRootItemsIn: composite [
	<gtInspectorPresentationOrder: 40>
	(self root gtInspectorItemsIn: composite)
		title: 'Root directory'
]

{ #category : #'*GT-Inspector' }
FileSystem >> gtInspectorWorkingDirectoryItemsIn: composite [
	<gtInspectorPresentationOrder: 40>
	(self workingDirectory gtInspectorItemsIn: composite)
		title: 'Working directory'
]
