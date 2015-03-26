Extension { #name : #TBehavior }

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior classSide >> gtExampleAllSubclasses [
	<gtExample: 'All Subclasses'>
	^ Object
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior classSide >> gtExampleClassVariables [
	<gtExample: 'Class Variables'>
	^ Behavior
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior classSide >> gtExampleCritics [
	<gtExample: 'Critics'>
	^ GTCritics forClass: GTCritics
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior classSide >> gtExampleInstanceVariables [
	<gtExample: 'Instance Variables'>
	^ ClassDescription
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior classSide >> gtExampleSuperclasses [
	<gtExample: 'Superclasses'>
	^ Metaclass
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior classSide >> gtExampleTraitComposition [
	<gtExample: 'Trait Composition'>
	^ Class
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior classSide >> gtExampleTraitUsers [
	<gtExample: 'Trait Users'>
	^ TBehavior
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior classSide >> gtExampleTraits [
	<gtExample: 'Traits'>
	^ Class
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterClassInstanceVariablesFor: aStep [
	<spotterOrder: 25>
	self isTrait ifTrue: [ ^ self ].
	aStep listProcessor
			title: 'Class instance variables';
			allCandidates: [ self class layout allSlots ];
			itemName: [:each | each name asString];
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterCompositionFor: aStep [
	<spotterOrder: 25>
	aStep listProcessor
			title: 'Composing traits';
			allCandidates: [ self traitComposition allTraits ];
			itemIcon: #systemIcon;
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterCriticsFor: aStep [
	<spotterOrder: 90>
	aStep listProcessor
		title: 'Critics';
		items: [ GTCritics forClass: self ];
		itemName: [ :item | item title ];
		itemIcon: [ Smalltalk ui icons smallWarningIcon ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterInstanceVariablesFor: aStep [
	<spotterOrder: 20>
	self isTrait ifTrue: [ ^ self ].
	aStep listProcessor
			title: 'Instance variables';
			allCandidates: [ self layout allSlots ];
			itemName: [:each | each name asString];
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterSubclassesFor: aStep [
	<spotterOrder: 50>
	aStep listProcessor
			title: 'All subclasses';
			allCandidates: [ self allSubclasses ];
			itemIcon: #systemIcon;
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterSuperclassesFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
			title: 'All superclasses';
			allCandidates: [ self allSuperclasses ];
			itemIcon: #systemIcon;
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterTraitUsersFor: aStep [
	<spotterOrder: 20>
	self isTrait ifFalse: [ ^ self ].
	aStep listProcessor
			title: 'Users';
			allCandidates: [ self traitUsers asArray ];
			itemIcon: #systemIcon;
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterUsedSlotsFor: aStep [
	<spotterOrder: 70>
	aStep listProcessor
			title: 'Special Slots';
			allCandidates: [ self slots select: [ :slot | slot isSpecial ] ];
			itemName: [ :item | item definitionString ];
			filter: GTFilterSubstring
]

{ #category : #'*GT-SpotterExtensions-Core' }
TBehavior >> spotterUsedTraitsFor: aStep [
	<spotterOrder: 60>
	aStep listProcessor
			title: 'Uses Traits';
			allCandidates: [ self traits asArray ];
			itemIcon: #systemIcon;
			filter: GTFilterSubstring
]
