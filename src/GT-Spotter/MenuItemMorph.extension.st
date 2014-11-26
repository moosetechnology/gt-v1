Extension { #name : #MenuItemMorph }

{ #category : #'*GT-Spotter' }
MenuItemMorph >> spotterActDefault [
	self doButtonAction
]

{ #category : #'*GT-Spotter' }
MenuItemMorph >> spotterItemsFor: aStep [
	<spotterOrder: 10>
	self hasSubMenu ifTrue: [ 
		self subMenu spotterItemsFor: aStep ]
]
