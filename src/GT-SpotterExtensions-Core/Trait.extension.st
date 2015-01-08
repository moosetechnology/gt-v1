Extension { #name : #Trait }

{ #category : #'*GT-SpotterExtensions-Core' }
Trait >> spotterActDefault [
	^ self browse
]

{ #category : #'*GT-SpotterExtensions-Core' }
Trait >> spotterTraitUsersFor: aStep [
	<spotterOrder: 15>
	aStep listProcessor
			title: 'Trait Users';
			allCandidates: [ self traitUsers asArray ];
			itemIcon: #systemIcon;
			matchSubstring
]
