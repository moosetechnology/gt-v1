Extension { #name : #FileSystem }

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
