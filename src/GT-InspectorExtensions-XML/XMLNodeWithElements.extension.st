Extension { #name : #XMLNodeWithElements }

{ #category : #'*gt-inspectorextensions-xml' }
XMLNodeWithElements >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite text 
		title: 'Source';
		format: [ self prettyPrinted ]
]

{ #category : #'*gt-inspectorextensions-xml' }
XMLNodeWithElements >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite tree 
		title: 'Tree';
		display: [ { self } ];
		children: #elements;
		format: [ :each | each name ]
]
