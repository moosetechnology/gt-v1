Extension { #name : #TBehavior }

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterClassInstanceVariablesFor: aStep [
	<spotterOrder: 25>
	aStep listProcessor
			title: 'Class instance variables';
			allCandidates: [ self class layout allSlots ];
			itemName: [:each | each name asString];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterInstanceVariablesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			title: 'Instance variables';
			allCandidates: [ self layout allSlots ];
			itemName: [:each | each name asString];
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterSubclassesFor: aStep [
	<spotterOrder: 50>
	aStep listProcessor
			title: 'All subclasses';
			allCandidates: [ self allSubclasses ];
			itemIcon: #systemIcon;
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterSuperclassesFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
			title: 'All superclasses';
			allCandidates: [ self allSuperclasses ];
			itemIcon: #systemIcon;
			matchSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterUsedTraitsFor: aStep [
	<spotterOrder: 60>
	aStep listProcessor
			title: 'Uses Traits';
			allCandidates: [ self traits asArray ];
			itemIcon: #systemIcon;
			matchSubstring
]
