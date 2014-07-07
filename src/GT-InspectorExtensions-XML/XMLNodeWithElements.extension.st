Extension { #name : #XMLNodeWithElements }

{ #category : #'*GT-InspectorExtensions-XML' }
XMLNodeWithElements >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite text 
		title: 'Source';
		format: [ self prettyPrinted ]
]

{ #category : #'*GT-InspectorExtensions-XML' }
XMLNodeWithElements >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite tree 
		title: 'Tree';
		display: [ { self } ];
		children: #elements;
		format: [ :each | each name ]
]
