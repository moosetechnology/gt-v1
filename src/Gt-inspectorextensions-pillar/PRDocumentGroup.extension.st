Extension { #name : #PRDocumentGroup }

{ #category : #'*GT-InspectorExtensions-Pillar' }
PRDocumentGroup >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite tree 
		title: 'Tree';
		display: [ { self } ];
		children: [ :each | 
			each hasChildren 
				ifTrue: [each children]
				ifFalse: [ { } ] ];
		when: #hasChildren
]
