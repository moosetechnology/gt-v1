Extension { #name : #SmaCCParseNode }

{ #category : #'*GT-InspectorExtensions-SmaCC' }
SmaCCParseNode >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite text
		title: 'Source';
		display: [self topParent source];
		initialize: [ :presentation | 
			presentation selectionInterval:
				((self startPosition - self topParent startPosition + 1) to: 
				(self stopPosition - self topParent startPosition + 1)) ]
]

{ #category : #'*GT-InspectorExtensions-SmaCC' }
SmaCCParseNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite tree
		title: 'AST';
		display: [{ self }];
		children: #children;
		format: [ :each | 
			(each source copyReplaceAll: String cr with: '')
				copyReplaceAll: String lf with: '' ]
]
