Extension { #name : #MenuMorph }

{ #category : #'*GT-SpotterExtensions-Core' }
MenuMorph >> allItems [
	| all |
	all := OrderedCollection new.
	self items do: [ :each |
		all add: each.
		each hasSubMenu 
			ifTrue: [ all addAll: each subMenu allItems ] ].
	^ all
]

{ #category : #'*GT-SpotterExtensions-Core' }
MenuMorph class >> gtExampleMenuMorph [
	<gtExample>
	^ self example
	
]

{ #category : #'*GT-SpotterExtensions-Core' }
MenuMorph >> spotterItemsFor: aStep [
	<spotterOrder: 10>
	self flag: #refactoringViolationForSpotterActDefault:.
	^ aStep listProcessor 
		title: 'Items';
		candidatesLimit: Float infinity;
		allCandidates: [ self items ];
		itemName: #contents;
		itemIcon: [ :item | item icon ];
		actLogic: [ :item :step | 
			item hasSubMenu 
				ifTrue: [ step diveIn ] 
				ifFalse: [ item spotterActDefault. step exit ] ];
		filter: GTFilterSubstring 
]
