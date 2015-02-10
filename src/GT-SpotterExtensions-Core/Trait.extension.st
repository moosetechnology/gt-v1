Extension { #name : #Trait }

{ #category : #'*GT-SpotterExtensions-Core' }
Trait >> spotterActDefault [
	^ self browse
]

{ #category : #'*GT-SpotterExtensions-Core' }
Trait >> spotterClassMethodsFor: aStep [
	<spotterOrder: 15>
	aStep listProcessor
			title: 'Class methods';
			allCandidates: [ self classTrait methods ];
			itemName: [ :method | method selector ];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
Trait >> spotterCompositionFor: aStep [
	<spotterOrder: 25>
	aStep listProcessor
			title: 'Composing traits';
			allCandidates: [ self traitComposition allTraits ];
			itemIcon: #systemIcon;
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
Trait >> spotterTraitUsersFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			title: 'Users';
			allCandidates: [ self traitUsers asArray ];
			itemIcon: #systemIcon;
			matchSubstring
]
