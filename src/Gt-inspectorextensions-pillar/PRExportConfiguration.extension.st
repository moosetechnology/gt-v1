Extension { #name : #PRExportConfiguration }

{ #category : #'*GT-InspectorExtensions-Pillar' }
PRExportConfiguration >> gtInspectorInputFilesIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Files';
		display: [self inputFiles];
		format: #basename
]
