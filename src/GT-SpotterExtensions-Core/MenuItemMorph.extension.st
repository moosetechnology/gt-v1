Extension { #name : #MenuItemMorph }

{ #category : #'*GT-SpotterExtensions-Core' }
MenuItemMorph >> spotterActDefault [
	self doButtonAction
]

{ #category : #'*GT-SpotterExtensions-Core' }
MenuItemMorph >> spotterItemsFor: aStep [
	<spotterOrder: 10>
	self hasSubMenu ifTrue: [ 
		self subMenu spotterItemsFor: aStep ]
]
