Extension { #name : #XMLNodeWithElements }

{ #category : #'*GT-InspectorExtensions-XML' }
XMLNodeWithElements >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #'*GT-InspectorExtensions-XML' }
XMLNodeWithElements classSide >> gtExampleXmlNode [
	<gtExample>
	^ XMLDocument gtExampleXmlNode nodes
]

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
		format: #gtDisplayString;
		when: [self hasElements];
		rootsExpanded
]

{ #category : #'*GT-InspectorExtensions-XML' }
XMLNodeWithElements >> gtName [
	^ ''
]
