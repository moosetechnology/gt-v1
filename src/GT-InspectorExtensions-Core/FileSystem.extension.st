Extension { #name : #FileSystem }

{ #category : #'*GT-InspectorExtensions-Core' }
FileSystem class >> gtExampleZip [
	<gtExample: 'Zip file system'>
	| zipFile zip |
	zipFile := FileSystem memory workingDirectory / 'test.zip'.
	zip := (FileSystem zip: zipFile) open.
	zip / 'sample.txt'
		writeStreamDo: [ :stream |
				stream nextPutAll: self comment ];
			yourself.
	^ zip
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileSystem >> gtInspectorRootItemsIn: composite [
	<gtInspectorPresentationOrder: 40>
	(self root gtInspectorItemsIn: composite)
		title: 'Root directory'
]

{ #category : #'*GT-InspectorExtensions-Core' }
FileSystem >> gtInspectorWorkingDirectoryItemsIn: composite [
	<gtInspectorPresentationOrder: 40>
	(self workingDirectory gtInspectorItemsIn: composite)
		title: 'Working directory'
]
