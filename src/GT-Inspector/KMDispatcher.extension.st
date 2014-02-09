Extension { #name : #KMDispatcher }

{ #category : #'*GT-Inspector' }
KMDispatcher >> gtInspectorMappingsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite tree 
		title: 'Keys';
		display: [ 
			(self targets collect: #category)
				add: self directKeymaps;
				yourself ];
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ];
		children: [ :item :treePresentation :level |
			(item isKindOf: KMCategory)
				ifFalse: [ #() ]
				ifTrue: [ item allEntries keymaps ] ];
		format: #gtDisplayString;
		allExpanded
]
