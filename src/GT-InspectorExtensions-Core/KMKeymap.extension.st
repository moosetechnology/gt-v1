Extension { #name : #KMKeymap }

{ #category : #'*GT-InspectorExtensions-Core' }
KMKeymap >> gtDisplayOn: aStream [
	aStream 
		nextPutAll: self name gtDisplayString;
		nextPutAll: ' on ';
		nextPutAll: self shortcut gtDisplayString;
		nextPutAll: ' do ' ;
		nextPutAll: self action gtDisplayString
]

{ #category : #'*GT-InspectorExtensions-Core' }
KMKeymap class >> gtExampleKeymapA [
	<gtExample: 'Keymap: a'>
	^ KMKeymap 
		named: #a 
		shortcut: $a asKeyCombination
		action: [ ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
KMKeymap class >> gtExampleKeymapFOO [
	<gtExample: 'Keymap: FOO'>
	^ KMKeymap 
		named: #Foo
		shortcut: $F asKeyCombination, $O asKeyCombination, $O asKeyCombination
		action: [ ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
KMKeymap >> gtInspectorSourceCodeIn: composite [
	<gtInspectorPresentationOrder: 30> 

	^ self action gtInspectorSourceCodeIn: composite
]
