Extension { #name : #SmaCCParseNode }

{ #category : #'*GT-InspectorExtensions-SmaCC' }
SmaCCParseNode >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite text
		title: 'Source';
		display: [self source]
]

{ #category : #'*GT-InspectorExtensions-SmaCC' }
SmaCCParseNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite tree
		title: 'AST';
		display: [{ self }];
		children: #children
]
