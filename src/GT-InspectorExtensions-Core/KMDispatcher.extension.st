Extension { #name : #KMDispatcher }

{ #category : #'*GT-InspectorExtensions-Core' }
KMDispatcher class >> gtExampleDispatcherWithTarget [
	<gtExample: 'Dispatcher with target'>
	^ self target: Morph new
]

{ #category : #'*GT-InspectorExtensions-Core' }
KMDispatcher class >> gtExampleDispatcherWithTargetAndShortcuts [
	<gtExample: 'Dispatcher with target and shortcuts'>
	^ BorderedMorph new kmDispatcher
]

{ #category : #'*GT-InspectorExtensions-Core' }
KMDispatcher class >> gtExampleEmptyDispatcher [
	<gtExample: 'Empty dispatcher'>
	^ self new
]

{ #category : #'*GT-InspectorExtensions-Core' }
KMDispatcher >> gtInspectorMappingsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite table 
		title: 'Keys';
		display: [ 
			((self targets collect: #category)
				add: self directKeymaps;
				yourself)
				flatCollect: [ :category | 
					category allEntries keymaps collect: [ :key | key -> category ] ]
				 ];
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ];
		column: 'Shortcut' evaluated: [ :assoc | assoc key shortcut gtDisplayString ] width: 120;
		column: 'Action' evaluated: [ :assoc | assoc key action gtDisplayString ];
		column: 'Description' evaluated: [ :assoc | assoc key description ];
		column: 'Category' evaluated: [ :assoc | '' ] tags: [ :assoc | assoc value name ifNil: [ #() ] ifNotNil: [ { assoc value name }]];
		send: #key
]
