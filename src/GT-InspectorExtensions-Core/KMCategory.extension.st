Extension { #name : #KMCategory }

{ #category : #'*GT-InspectorExtensions-Core' }
KMCategory >> gtDisplayOn: stream [
	^ stream nextPutAll: self name asString
]

{ #category : #'*GT-InspectorExtensions-Core' }
KMCategory >> gtInspectorMappingsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Keys';
		display: [ self allEntries keymaps ];
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ];
		format: #gtDisplayString;
		when: [ self allEntries keymaps notEmpty ]
]
