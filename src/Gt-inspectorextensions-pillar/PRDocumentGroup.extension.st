Extension { #name : #PRDocumentGroup }

{ #category : #'*GT-InspectorExtensions-Pillar' }
PRDocumentGroup >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite text 
		title: 'Text';
		display: [ self text ]
]

{ #category : #'*GT-InspectorExtensions-Pillar' }
PRDocumentGroup >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite tree 
		title: 'Tree';
		display: [ { self } ];
		children: #children
]
