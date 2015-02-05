Extension { #name : #TraitBehavior }

{ #category : #'*GT-SpotterExtensions-Core' }
TraitBehavior >> spotterCompositionFor: aStep [
	<spotterOrder: 25>
	aStep listProcessor
			title: 'Composing traits';
			allCandidates: [ self traitComposition allTraits ];
			itemIcon: #systemIcon;
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TraitBehavior >> spotterTraitUsersFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			title: 'Users';
			allCandidates: [ self traitUsers asArray ];
			itemIcon: #systemIcon;
			matchSubstring
]
