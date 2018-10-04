Extension { #name : #KMKeymap }

{ #category : #'*GT-Examples-Examples' }
KMKeymap class >> gtExampleKeymapA [
	<gtExample>
	<label: 'Keymap: a'>
	
	^ self 
		named: #a 
		shortcut: $a asKeyCombination
		action: [ ]
]

{ #category : #'*GT-Examples-Examples' }
KMKeymap class >> gtExampleKeymapFOO [
	<gtExample>
	<label: 'Keymap: FOO'>
	
	^ self 
		named: #Foo
		shortcut: $F asKeyCombination, $O asKeyCombination, $O asKeyCombination
		action: [ ]
]
