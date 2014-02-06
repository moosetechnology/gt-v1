Extension { #name : #KMCategory }

{ #category : #'*GT-Inspector' }
KMCategory >> gtDisplayOn: stream [
	^ stream nextPutAll: self name asString
]

{ #category : #'*GT-Inspector' }
KMCategory >> gtInspectorMappingsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Mappings';
		display: [ self allEntries keymaps ];
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ];
		format: #gtDisplayString
]
