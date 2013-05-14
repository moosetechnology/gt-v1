Extension { #name : #FileReference }

{ #category : #'*gt-inspector' }
FileReference >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite text
			title: 'Contents';
			display: [ :each | each readStreamDo: [ :stream | stream contents ] ];
			when: [ :each | each isFile ]
]
