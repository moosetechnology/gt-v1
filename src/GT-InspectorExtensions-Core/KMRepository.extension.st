Extension { #name : #KMRepository }

{ #category : #'*GT-InspectorExtensions-Core' }
KMRepository class >> gtExampleDefault [
	<gtExample>
	^ self default
]

{ #category : #'*GT-InspectorExtensions-Core' }
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

{ #category : #'*GT-InspectorExtensions-Core' }
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
