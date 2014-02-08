Extension { #name : #KMRepository }

{ #category : #'*GT-Inspector' }
KMRepository class >> gtExampleDefault [
	<gtExample>
	^ self default
]

{ #category : #'*gt-inspector' }
KMRepository >> gtInspectorGlobalsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite tree 
		title: 'Global keys';
		display: #globalCategories;
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ];
		children: [ :item :treePresentation :level |
			level > 1 
				ifTrue: [ #() ]
				ifFalse: [ item allEntries keymaps  ] ];
		format: #gtDisplayString
]

{ #category : #'*gt-inspector' }
KMRepository >> gtInspectorMappingsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite tree 
		title: 'Keys';
		display: #categories;
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ];
		children: [ :item :treePresentation :level |
			level > 1 
				ifTrue: [ #() ]
				ifFalse: [ item allEntries keymaps  ] ];
		format: #gtDisplayString
]
