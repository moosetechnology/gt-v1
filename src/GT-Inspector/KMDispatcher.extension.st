Extension { #name : #KMDispatcher }

{ #category : #'*GT-Inspector' }
KMDispatcher >> gtInspectorMappingsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite tree 
		title: 'Mappings';
		display: [self targets collect: #category];
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ];
		children: [ :item :treePresentation :level |
			level > 1 
				ifTrue: [ #() ]
				ifFalse: [ item allEntries keymaps  ] ];
		format: #gtDisplayString
]
