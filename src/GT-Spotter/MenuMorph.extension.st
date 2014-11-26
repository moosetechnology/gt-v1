Extension { #name : #MenuMorph }

{ #category : #'*GT-Spotter' }
MenuMorph >> allItems [
	| all |
	all := OrderedCollection new.
	self items do: [ :each |
		all add: each.
		each hasSubMenu 
			ifTrue: [ all addAll: each subMenu allItems ] ].
	^ all
]

{ #category : #'*GT-Spotter' }
MenuMorph >> spotterItemsFor: aStep [
	<spotterOrder: 10>
	^ aStep listProcessor 
		title: 'Items';
		candidatesLimit: Float infinity;
		allCandidates: [ self items ];
		itemName: #contents;
		itemIcon: [ :item | item icon ];
		actLogic: [ :item | item hasSubMenu 
					ifTrue: [ aStep diveIn ] 
					ifFalse: [ item spotterActDefault. aStep exit ] ];
		matchSubstring 
]
