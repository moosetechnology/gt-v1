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
MenuMorph >> mainItems [
	| all |
	all := OrderedCollection new.
	self items do: [ :each |
		all add: each.
		(each hasSubMenu and: [ each contents = 'Tools' ]) 
			ifTrue: [ all addAll: each subMenu allItems ] ].
	^ all
]

{ #category : #'*GT-SpotterExtensions-Core' }
MenuMorph >> spotterItemsFor: aStep [
	<spotterOrder: 10>
	self flag: #refactoringViolationForSpotterActDefault:.
	^ aStep listProcessor 
		title: 'Items';
		candidatesLimit: Float infinity;
		allCandidates: [ self mainItems ];
		itemName: #contents;
		itemIcon: [ :item | item icon ];
		actLogic: [ :item | 
			item hasSubMenu 
				ifTrue: [ aStep diveIn ] 
				ifFalse: [ item spotterActDefault. aStep exit ] ];
		filter: GTFilterSubstring 
]
