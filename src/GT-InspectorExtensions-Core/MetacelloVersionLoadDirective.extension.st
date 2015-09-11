Extension { #name : #MetacelloVersionLoadDirective }

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloVersionLoadDirective >> gtInspectorChildren [
	^ self loadDirectives
]

{ #category : #'*GT-InspectorExtensions-Core' }
MetacelloVersionLoadDirective >> gtInspectorLoadDirectivesIn: composite [
	<gtInspectorPresentationOrder: 1>
	composite tree
		title: 'Load directives';
		display: [ { self } ];
		format: #label;
		children: #gtInspectorChildren
]
