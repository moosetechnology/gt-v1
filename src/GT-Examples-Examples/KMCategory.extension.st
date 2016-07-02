Extension { #name : #KMCategory }

{ #category : #'*GT-Examples-Examples' }
KMCategory class >> gtExampleCategoryWithEntry [
	<gtExample>
	^ (self named: '1 Entry') 
		addKeymapEntry: (KMKeymap 
								named: #FooBar 
								shortcut: $a asKeyCombination
								action: [ ]);
		yourself
]

{ #category : #'*GT-Examples-Examples' }
KMCategory class >> gtExampleEmptyCategory [
	<gtExample>
	^ self named: 'Empty Example'
]
