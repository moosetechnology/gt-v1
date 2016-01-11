Extension { #name : #SystemNavigation }

{ #category : #'*GT-SpotterExtensions-Core-private' }
SystemNavigation >> allReferencesTo: aLiteral do: aBlock [
	| symbol |
	symbol := aLiteral isSymbol.
	self allBehaviorsDo: [ :class |
		symbol
			ifFalse: [ class withMethodsReferTo: aLiteral do: aBlock ]
			ifTrue: [ class withThorougMethodsReferTo: aLiteral do: aBlock ] ]
]

{ #category : #'*GT-SpotterExtensions-Core-private' }
SystemNavigation >> allReferencesToSubstring: aString do: aBlock [
	aString isEmptyOrNil ifTrue: [ ^ self ].
	self allBehaviorsDo: [ :class |
		(class name includesSubstring: aString caseSensitive: false) ifTrue: [
			self allReferencesTo: class binding do: aBlock ] ]
]

{ #category : #'*GT-SpotterExtensions-Core-private' }
SystemNavigation >> allSendersToSubstring: aString do: aBlock [
	aString isEmptyOrNil ifTrue: [ ^ self ].
	aString asSymbol ifNotNil: [ :symbol |
		self allBehaviorsDo: [ :class | 
			class withMethodSender: symbol do: aBlock ] ]
]
